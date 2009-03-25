package Net::OpenSocial::Client::HTTPRequestBuilder::HMAC;

use Any::Moose;
with 'Net::OpenSocial::Client::HTTPRequestBuilder';

use OAuth::Lite::Consumer;
use OAuth::Lite::AuthMethod qw(URL_QUERY);
use OAuth::Lite::Token;
use HTTP::Headers;
use HTTP::Request;
use bytes ();

has 'consumer_secret' => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

has 'consumer_key' => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

has 'token' => (
    is  => 'ro',
    isa => 'OAut::Lite::Token',
);

has 'requestor' => (
    is  => 'ro',
    isa => 'Str',
);

sub build_request {
    my ( $self, %args ) = @_;

    my $method       = $args{method};
    my $url          = $args{url};
    my $params       = $args{params};
    my $content_type = $args{content_type};
    my $content      = $args{content};
    my $token        = $self->token;

    $params ||= {};
    $params->{xoauth_requestor_id} = $self->requestor
        if $self->requestor;


    my $consumer = OAuth::Lite::Consumer->new(
        consumer_key    => $self->consumer_key,
        consumer_secret => $self->consumer_secret,
        auth_method     => URL_QUERY,
    );
    my $query = $consumer->gen_auth_query($method, $url, $token, $params);
    $url = sprintf q{%s?%s}, $url, $query;

    my $headers = HTTP::Headers->new;
    if ( $method eq 'POST' || $method eq 'PUT' ) {
        $headers->header('Content-Type' => $content_type);
        $headers->header('Content-Length' => bytes::length($content) );
    }

    my $http_req = HTTP::Request->new( $method, $url, $headers, $content );

    return $http_req;
}

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

