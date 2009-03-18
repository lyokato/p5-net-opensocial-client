package Net::OpenSocial::Client::HTTPRequestBuilder::ST;

use Any::Moose;
with 'Net::OpenSocial::Client::HTTPRequestBuilder';

use HTTP::Request;
use URI;
use bytes();

has 'st' => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

sub build_request {
    my ( $self, %args ) = @_;

    my $method       = $args{method};
    my $url          = $args{url};
    my $params       = $args{parmas};
    my $content_type = $args{content_type};
    my $content      = $args{content};

    my $uri = URI->new($url);
    $params ||= {};
    $params->{st} = $self->st;
    $uri->query_form(%$params);
    my $http_req = HTTP::Request->new( $method => $uri->as_string );
    $http_req->header( 'Content-Type'   => $content_type );
    $http_req->header( 'Content-Length' => bytes::length($content) );
    $http_req->content($content);
    return $http_req;
}

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

