package Net::OpenSocial::Client::AuthMethod::HMAC;

use Any::Moose;
use OAuth::Lite::Consumer;

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
    is => 'ro',
    isa => 'OAut::Lite::Token',
);

has 'requestor' => (
    is  => 'ro',
    isa => 'Str',
);

sub sign {
    my ( $self, $request, $method, $url, $extra_params ) = @_;
    my $consumer = OAuth::Lite::Consumer->new(
        consumer_key    => $self->consumer_key,
        consumer_secret => $self->consumer_secret,
    );
    my $params = {};
    $params->{token} = $self->token  if $self->token;
    $params->{extra} = $extra_params if $extra_params;
    my $header = $consumer->gen_auth_header($method, $url, $params);
    $request->header( 'Authorization' => $header );
}

sub params {
    my $self   = shift;
    my $params = {};
    $params->{xoauth_requestor_id} = $self->requestor
        if $self->requestor;
    return $params;
}

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

