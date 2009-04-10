package Net::OpenSocial::Client::Type::Protocol;

use strict;
use warnings;

use base 'Exporter';

our @EXPORT_OK = qw(REST RPC);

use constant REST => 0;
use constant RPC  => 1;

1;

=head1 NAME

Net::OpenSocial::Client::Type::Protocol - Constants for protocol-type

=head1 SYNOPSIS

    use Net::OpenSocial::Client::Type::Protocol qw(REST RPC);
    say REST;
    say RPC;

=head1 DESCRIPTION

Constants for protocol-type

=head1 VALUES

=over 4

=item REST

Use RESTful API.
See L<Net::OpenSocial::Client::Protocol::REST>.

=item RPC

Use RPC.
See L<Net::OpenSocial::Client::Protocol::RPC>.

=back

=head1 AUTHOR

Lyo Kato, E<lt>lyo.kato@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Lyo Kato

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut

