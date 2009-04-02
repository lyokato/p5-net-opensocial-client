package Net::OpenSocial::Client::Container;

use Any::Moose;

has 'request_token_path' => (
    is  => 'ro',
    isa => 'Str',
);

has 'authorize_path' => (
    is  => 'ro',
    isa => 'Str',
);

has 'access_token_path' => (
    is  => 'ro',
    isa => 'Str',
);

has 'rest_endpoint' => (
    is  => 'ro',
    isa => 'Str',
);

has 'rpc_endpoint' => (
    is  => 'ro',
    isa => 'Str',
);

has 'use_request_body_hash' => (
    is      => 'ro',
    isa     => 'Bool',
    default => 0,
);

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

=head1 NAME

Net::OpenSocial::Client::Container - Container configuration

=head1 SYNOPSIS

    my $container = Net::OpenSocial::Client::Container->new(
        rest_endpoint         => q{http://example.org/rest},
        rpc_endpoint          => q{http://example.org/rpc},
        use_request_body_hash => 1,
    );

=head1 DESCRIPTION

Container confguration and provides some methods to support container specific implementation.

=head1 USAGE

=head2 BUILD BY YOURSELF

    my $container = Net::OpenSocial::Client::Container->new(
        rest_endpoint         => q{http://example.org/rest},
        rpc_endpoint          => q{http://example.org/rpc},
        use_request_body_hash => 1,
    );

=head2 USE SUBCLASS

There already exist some major container classes.
See L<Net::OpenSocial::Client::Container::Orkut>,
L<Net::OpenSocial::Client::Container::MySpace>,
L<Net::OpenSocial::Client::Container::Google>,
L<Net::OpenSocial::Client::Container::FriendConnect>

    my $container = Net::OpenSocial::Client::Container::Orkut->new;

or if you need new class for another container.
You should make new class extending this.


=head1 METHODS

=head2 request_token_path

OAuth request-token endpoint

=head2 authorize_path

OAuth authorization endpoint

=head2 access_token_path

OAuth access-token endpoint

=head2 rest_endpoint

RESTful API endpoint URL of container.

=head2 rpc_endpoint

RPC endpoint URL of container.

=head2 use_request_body_hash

if container use OAuth Request Body Hash extension or not.
Set 0 by default.

=head1 AUTHOR

Lyo Kato, E<lt>lyo.kato@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Lyo Kato

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut

