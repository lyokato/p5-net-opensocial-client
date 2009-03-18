package Net::OpenSocial::Client::Protocol::REST;

use Any::Moose;
extends 'Net::OpenSocial::Client::Protocol';
with 'Net::OpenSocial::Client::ErrorHandler';

use Net::OpenSocial::Client::ResultSet;

override 'execute' => sub {
    my ( $self, $container, $requests ) = @_;

    return $self->ERROR(q{This container doesn't support rest endpoint.})
        unless $container->rest;

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

        my %build_args = (
            method => $method,
            url    => $url,
            params => {%params},
        );

        if ( $method eq 'POST' || $method eq 'PUT' ) {
            my $resource = $request->resource;
            unless ($resource) {
                return $self->ERROR(q{});
            }
            $build_args{content_type} = $self->formatter->content_type;
            $build_args{content}
                = $self->formatter->encode( $resource->to_hash );
        }

        my $http_req = $self->request_builder->build_request(%build_args);
        my $http_res = $self->agent->request($http_req);

        unless ( $http_res->is_success ) {
            return $self->ERROR( $http_res->status_line );
        }
        my $res = $self->formatter->decode( $http_res->content );
        $result->set_result( $request->id => $res );
    }
    return $result;
};

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

