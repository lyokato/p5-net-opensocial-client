package Net::OpenSocial::Client::Protocol::REST;

use Any::Moose;
extends 'Net::OpenSocial::Client::Protocol';

use HTTP::Request;
use bytes ();

sub execute {
    my ( $self, $container ) = @_;

    my $result = [];
    for my $request ( @{ $self->_requests } ) {
        my $method   = $request->http_method_for_operation();
        my %params   = %{ $request->params };
        my $user_id  = delete $params{user_id};
        my $group_id = delete $params{group_id};
        my $p_id     = delete $params{p_id};
        my $url      = join(
            '/',
            grep {defined} (
                $container->endpoint, $container->rest,
                $request->service,    $user_id,
                $group_id,            $p_id
            )
        );
        my $http_req = HTTP::Request->new( $method => $url );
        my $auth_params = $self->auth_method->params();
        #$params = {%params, %$auth_params};
        my $params = {%$auth_params};
        $self->auth_method->sign( $http_req, $url, $method, $params );

        if ( $method eq 'POST' || $method eq 'PUT' ) {
            my $resource = $request->resource;
            unless ($resource) {
                #XXX: error
            }
            my $content = $self->formatter->encode( $resource->to_hash );
            $http_req->header( 'Content-Type' => $self->formatter->content_type );
            $http_req->header( 'Content-Length' => bytes::length($content) );
            $http_req->content($content);
        }
        my $http_res = $self->agent->request($http_req);

        unless ( $http_res->is_success ) {

        }
        my $res = $self->formatter->decode( $http_res->content );
        push(@$result, $res);
    }
    $self->clear_requests();
    return $result;
}



no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

