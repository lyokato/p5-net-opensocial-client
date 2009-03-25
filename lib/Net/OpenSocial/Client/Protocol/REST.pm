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

    my $result = Net::OpenSocial::Client::ResultSet->new;
    for my $request (@$requests) {

        my $method = $request->http_method_for_operation();

        my %params = %{ $request->params };
        my $app_id = delete $params{appId};

        my $url = join(
            '/',
            grep { defined($_) && $_ ne '' } (
                $container->endpoint, $container->rest,
                $request->service,    $request->user_id,
                $request->group_id,   $app_id,
            )
        );

        $params{format} = $self->formatter->name;

        my %build_args = (
            method => $method,
            url    => $url,
            params => {%params},
        );

        if ( $method eq 'POST' || $method eq 'PUT' ) {
            unless ( $request->has_resource ) {
                return $self->ERROR(q{});
            }
            my $resource = $request->resource;
            $build_args{content_type} = $self->formatter->content_type;
            $build_args{content}
                = $self->formatter->encode( $resource->fields );
        }

        my $http_req = $self->request_builder->build_request(%build_args);
        use Data::Dump qw(dump);
        warn dump($http_req);
        my $http_res = $self->agent->request($http_req);
        warn dump($http_res);

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
            $coll->add_resource($resource);
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

