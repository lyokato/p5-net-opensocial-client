package Net::OpenSocial::Client::Protocol::RPC;

use Any::Moose;
extends 'Net::OpenSocial::Client::Protocol';

use HTTP::Request;
use bytes ();

sub execute {
    my ( $self, $container ) = @_;

    my $url = sprintf( q{%s/%s}, $container->endpoint, $container->rpc );
    my $method = 'POST';
    my $http_req    = HTTP::Request->new( $method => $url );
    my $auth_params = $self->auth_method->params();
    my $params      = { %$auth_params };
    $self->auth_method->sign( $http_req, $url, $method, $params );

    my @obj;
    for my $request ( @{ $self->_requests } ) {
        my $obj = {};
        $obj->{method}
            = sprintf( q{%s.%s}, $request->rpc_service, $request->operation );
        $obj->{id}     = $request->id;
        $obj->{params} = $request->params;
        push( @obj, $obj );
    }
    my $content = $self->formatter->encode( @obj > 1 ? [@obj] : $obj[0] );
    $http_req->header( 'Content-Type'   => $self->formatter->content_type );
    $http_req->header( 'Content-Length' => bytes::length($content) );
    $http_req->content($content);

    my $http_res = $self->agent->request($http_req);
    unless ( $http_res->is_success ) {

    }
    my $result = $self->formatter->decode( $http_res->content );
    unless ( ref $result eq 'ARRAY' ) {
        $result = [$result];
    }
    $self->clear_requests();
    return $result;
}


no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

