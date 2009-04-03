package Net::OpenSocial::Client::Protocol::REST;

use Any::Moose;
extends 'Net::OpenSocial::Client::Protocol';
with 'Net::OpenSocial::Client::ErrorHandler';

use Net::OpenSocial::Client::ResultSet;
use Net::OpenSocial::Client::Result;
use Net::OpenSocial::Client::Resource::Factory;
use Net::OpenSocial::Client::Collection;

override 'execute' => sub {
    my ( $self, $container, $requests ) = @_;

    return $self->ERROR(q{This container doesn't support rest endpoint.})
        unless $container->rest_endpoint;

    my $result = Net::OpenSocial::Client::ResultSet->new;
    for my $request (@$requests) {

        my $method = $request->http_method_for_operation();

        my %params = %{ $request->params };
        my $app_id = delete $params{appId};

        my $url = join(
            '/',
            grep { defined($_) && $_ ne '' } (
                $container->rest_endpoint, $request->service,
                $request->user_id,         $request->group_id,
                $app_id,
            )
        );

        $params{format} = $self->formatter->name;

        my %build_args = (
            method    => $method,
            url       => $url,
            params    => {%params},
            container => $container,
        );

        if ( $method eq 'POST' || $method eq 'PUT' ) {
            unless ( $request->has_resource ) {
                return $self->ERROR(q{No resource data found.});
            }
            my $resource = $request->resource;
            $build_args{content_type} = $self->formatter->content_type;
            $build_args{content}
                = $self->formatter->encode( $resource->fields );
        }

        my $http_req = $self->request_builder->build_request(%build_args);
        my $http_res = $self->agent->request($http_req);

        unless ( $http_res->is_success ) {
            my $error = Net::OpenSocial::Client::Result->new(
                is_error => 1,
                code     => $http_res->code,
                message  => $http_res->message,
            );
            $result->set_result( $request->id => $error );
            next;
        }
        my $res = $self->formatter->decode( $http_res->content );
        $result->set_result(
            $request->id => $self->_build_result( $request->service, $res ) );
    }
    return $result;
};

sub _build_result {
    my ( $self, $service, $obj ) = @_;
    $obj ||= {};
    my $result = exists $obj->{response} ? $obj->{response} : $obj;
    if ( exists $result->{entry} ) {
        my $entries = $result->{entry};
        $entries = [$entries] unless ref $entries eq 'ARRAY';
        my $coll = Net::OpenSocial::Client::Collection->new;
        $coll->total_results( $result->{totalResults} )
            if exists $result->{totalResults};
        $coll->start_index( $result->{startIndex} )
            if exists $result->{startIndex};
        $coll->items_per_page( $result->{itemsPerPage} )
            if exists $result->{itemsPerPage};
        for my $entry (@$entries) {
            my $resource
                = Net::OpenSocial::Client::Resource::Factory->gen_resource(
                $service, $entry );
            $coll->add_item($resource);
        }
        return Net::OpenSocial::Client::Result->new( data => $coll );
    }
    else {

        # VOID result
        return Net::OpenSocial::Client::Result->new;
    }
}

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

=head1 NAME

Net::OpenSocial::Client::Protocol::REST - Protocol class for RESTful API.

=head1 SYNOPSIS

    my $protocol = Net::OpenSocial::Client::Protocol::REST->new(
        formatter       => Net::OpenSocial::CLient::Formatter::JSON->new,
        request_builder => Net::OpenSocial::Client::HTTPRequestBuilder::OAuth->new(...),
        agent           => LWP::UserAgent->new,
    );
    my $result_set = $protocol->execute($container, $requests);

=head1 DESCRIPTION

Protocol class for RESTful API.

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
