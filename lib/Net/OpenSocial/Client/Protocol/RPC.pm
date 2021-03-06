package Net::OpenSocial::Client::Protocol::RPC;

use Any::Moose;
extends 'Net::OpenSocial::Client::Protocol';
with 'Net::OpenSocial::Client::ErrorHandler';

use Net::OpenSocial::Client::ResultSet;
use Net::OpenSocial::Client::Result;
use Net::OpenSocial::Client::Collection;
use Net::OpenSocial::Client::Resource::Factory;
use Net::OpenSocial::Client::Type::Operation qw(CREATE UPDATE);

override 'execute' => sub {
    my ( $self, $container, $requests ) = @_;

    my $url = $container->rpc_endpoint;
    return $self->ERROR(q{This container doesn't support RPC endpoint.})
        unless $url;
    my $method = 'POST';

    my @obj;
    my %id_req_map = ();
    for my $request (@$requests) {
        my $service   = $request->rpc_service;
        my $operation = $request->operation;
        my $obj       = {};
        $obj->{method}          = sprintf( q{%s.%s}, $service, $operation );
        $obj->{id}              = $request->id;
        $obj->{params}          = $request->params;
        $obj->{params}{userId}  = $request->user_id;
        $obj->{params}{groupId} = $request->group_id;
        if (   $operation eq CREATE
            || $operation eq UPDATE )
        {
            unless ( $request->has_resource ) {
                return $self->ERROR(q{CREATE/UPDATE operations need resource.});
            }
            my $resource = $request->resource;
            $obj->{params}{$service} = $resource->fields;
        }
        push( @obj, $obj );
        $id_req_map{ $request->id } = $request;
    }
    my $content = $self->formatter->encode( @obj > 1 ? [@obj] : $obj[0] );

    my $http_req = $self->request_builder->build_request(
        method       => $method,
        url          => $url,
        container    => $container,
        content_type => $self->formatter->content_type,
        content      => $content,
    );

    my $http_res = $self->agent->request($http_req);

    my $result_set = Net::OpenSocial::Client::ResultSet->new;
    unless ( $http_res->is_success ) {
        for my $request (@$requests) {
            my $error = Net::OpenSocial::Client::Result->new(
                is_error => 1,
                code     => $http_res->code,
                message  => $http_res->message,
            );
            $result_set->set_result( $request->id => $error );
        }
        return $result_set;
    }
    my $results = $self->formatter->decode( $http_res->content );

    unless ( ref $results eq 'ARRAY' ) {
        $results = [$results];
    }
    for my $result (@$results) {
        my $res_id
            = exists $result->{id} ? $result->{id} : $requests->[0]->id;
        my $origin_req = $id_req_map{$res_id};
        $result_set->set_result(
            $res_id => $self->_build_result( $origin_req->service, $origin_req->operation, $result ) );
    }
    return $result_set;
};

sub _build_result {
    my ( $self, $service, $operation, $obj ) = @_;
    $obj ||= {};
    if ( exists $obj->{error} ) {
        return Net::OpenSocial::Client::Result->new(
            is_error => 1,
            %{ $obj->{error} }
        );
    }
    else {

        #my $result = exists $obj->{result} ? $obj->{result} : $obj;
        my $result = $obj->{data} || {};
        if ( ( $operation eq CREATE || $operation eq UPDATE ) && scalar( keys %$result ) == 0 ) {

            # VOID result
            return Net::OpenSocial::Client::Result->new();
        }
        else {
            my $coll = Net::OpenSocial::Client::Collection->new();
            if ( exists $result->{list} ) {
                $coll->total_results( $result->{totalResults} )
                    if exists $result->{totalResults};
                $coll->start_index( $result->{startIndex} )
                    if exists $result->{startIndex};
                $coll->items_per_page( $result->{itemsPerPage} )
                    if exists $result->{itemsPerPage};
                my $list = $result->{list};
                unless ( ref $list eq 'ARRAY' ) {

                    # invalid response format
                }
                for my $item ( @{ $result->{list} } ) {
                    my $resource = Net::OpenSocial::Client::Resource::Factory
                        ->gen_resource( $service, $item );
                    $coll->add_item($resource);
                }
            }
            elsif ( keys %$result > 0 ) {
                my $resource = Net::OpenSocial::Client::Resource::Factory
                    ->gen_resource( $service, $result );
                $coll->add_item($resource);
            }
            return Net::OpenSocial::Client::Result->new( data => $coll );
        }
    }
}

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

=head1 NAME

Net::OpenSocial::Client::Protocol::PRC - Protocol class for RPC.

=head1 SYNOPSIS

    my $protocol = Net::OpenSocial::Client::Protocol::RPC->new(
        formatter       => Net::OpenSocial::CLient::Formatter::JSON->new,
        request_builder => Net::OpenSocial::Client::HTTPRequestBuilder::OAuth->new(...),
        agent           => LWP::UserAgent->new,
    );
    my $result_set = $protocol->execute($container, $requests);

=head1 DESCRIPTION

Protocol class for RPC.

=head1 METHODS

=head2 execute($container, $requests)

=head1 SEE ALSO

L<Net::OpenSocial::Client::Protocol>

=head1 AUTHOR

Lyo Kato, E<lt>lyo.kato@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Lyo Kato

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut
