package Net::OpenSocial::Client::Type::Auth;

use strict;
use warnings;

use base 'Exporter';

our @EXPORT_OK = qw(OAUTH ST);

use constant OAUTH => 0;
use constant ST    => 1;

1;

=head1 NAME

Net::OpenSocial::Client::Type::Auth - Constants for auth-type

=head1 SYNOPSIS

    use Net::OpenSocial::Client::Type::Auth qw(OAUTH ST);
    say OAUTH;
    say ST;

=head1 DESCRIPTION

Constants for auth-type

=head1 VALUES

=over 4

=item OAUTH

Use 2-legged or 3-legged OAuth.
See L<Net::OpenSocial::Client::RequestBuilder::OAuth> for more detail.

=item ST

Use security-token for authentication.
See L<Net::OpenSocial::Client::RequestBuilder::ST> for more detail.

=back

=head1 AUTHOR

Lyo Kato, E<lt>lyo.kato@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Lyo Kato

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut

