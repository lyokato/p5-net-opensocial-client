package Net::OpenSocial::Client::Container;

use Any::Moose;

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

Net::OpenSocial::Client::Container - Container Information

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 AUTHOR

Lyo Kato, E<lt>lyo.kato@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Lyo Kato

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut

