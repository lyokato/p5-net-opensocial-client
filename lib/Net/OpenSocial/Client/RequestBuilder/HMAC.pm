package Net::OpenSocial::Client::RequestBuilder::HMAC;

use Any::Moose;
with 'Net::OpenSocial::Client::RequestBuilder';

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
    my $params       = $args{parmas};
    my $content_type = $args{content_type};
    my $content      = $args{content};

    my $consumer = OAuth::Lite::Consumer->new(
        consumer_key    => $self->consumer_key,
        consumer_secret => $self->consumer_secret,
    );
    my %oauth_args = (
        method => $method,
        url    => $url,
    );
    $oauth_args{token}   = $self->token if $self->token;
    $oauth_args{content} = $content     if $content;
    $oauth_args{headers} = [ 'Content-Type' => $content_type ]
        if $content_type;

    $params ||= {};
    $params->{xoauth_requestor_id} = $self->requestor
        if $self->requestor;

    $oauth_args{params} = $params;
    my $http_req = $consumer->gen_oauth_request(%oauth_args);
    return $http_req;
}

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

