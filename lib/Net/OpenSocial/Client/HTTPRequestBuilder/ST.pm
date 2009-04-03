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
    my $container    = $args{container};

    my $uri = URI->new($url);
    $params ||= {};
    $params->{st} = $self->st;
    $uri->query_form(%$params);
    my $http_req = HTTP::Request->new( $method => $uri->as_string );
    if ( $method eq 'POST' || $method eq 'PUT' ) {
        $http_req->header( 'Content-Type'   => $content_type );
        $http_req->header( 'Content-Length' => bytes::length($content) );
        $http_req->content($content);
    }
    return $http_req;
}

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

=head1 NAME

Net::OpenSocial::Client::HTTPRequestBuilder::ST - Security token request builder

=head1 SYNOPSIS

    my $builder = Net::OpenSocial::Client::HTTPRequestBuilder::ST->new(
        st => q{securitytokenvalue},
    );

    my $http_req = $builder->build_request(...);

=head1 DESCRIPTION

HTTP Request builder with security-token authentication

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

