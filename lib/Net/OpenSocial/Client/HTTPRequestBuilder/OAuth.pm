package Net::OpenSocial::Client::HTTPRequestBuilder::OAuth;

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
    my $container    = $args{container};
    my $token        = $self->token;

    $params ||= {};
    $params->{xoauth_requestor_id} = $self->requestor
        if $self->requestor;

    my $use_request_body_hash = $container->use_request_body_hash ? 1 : 0;

    # now OAuth::Lite 1.16 supports Request Body Hash
    my $consumer = OAuth::Lite::Consumer->new(
        consumer_key          => $self->consumer_key,
        consumer_secret       => $self->consumer_secret,
        auth_method           => URL_QUERY,
        use_request_body_hash => $use_request_body_hash,
    );

    my %oauth_args = (
        method => $method,
        url    => $url,
        params => $params,
    );
    $oauth_args{token} = $token if $token;
    if ( $method eq 'POST' || $method eq 'PUT' ) {
        $oauth_args{content} = $content if $content;
        $oauth_args{headers} = [ 'Content-Type' => $content_type ];
    }
    my $http_req = $consumer->gen_oauth_request(%oauth_args);
=pod
    my $query = $consumer->gen_auth_query( $method, $url, $token, $params );
    $url = sprintf q{%s?%s}, $url, $query;

    my $headers = HTTP::Headers->new;
    if ( $method eq 'POST' || $method eq 'PUT' ) {
        $headers->header( 'Content-Type'   => $content_type );
        $headers->header( 'Content-Length' => bytes::length($content) );
    }

    my $http_req = HTTP::Request->new( $method, $url, $headers, $content );

=cut
    return $http_req;
}

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

=head1 NAME

Net::OpenSocial::Client::HTTPRequestBuilder::OAuth - OAuth request builder

=head1 SYNOPSIS

    # 3legged
    # get access token before hand.
    my $builder = Net::OpenSocial::Client::HTTPRequestBuilder::OAuth->new(
        consumer_key    => $consumer_key,
        consumer_secret => $consumer_secret,
        token           => $access_token,
    );

    # or 2legged
    my $builder = Net::OpenSocial::Client::HTTPRequestBuilder::OAuth->new(
        consumer_key    => $consumer_key,
        consumer_secret => $consumer_secret,
        requestor       => $xoauth_requestor_id,
    );

    my $http_request = $builder->build_request();

=head1 DESCRIPTION

=head1 METHODS

=head2 build_request

=head1 AUTHOR

Lyo Kato, E<lt>lyo.kato@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Lyo Kato

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut

