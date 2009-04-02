package Net::OpenSocial::Client::Type::Format;

use strict;
use warnings;

use base 'Exporter';

our @EXPORT_OK = qw(JSON XML ATOM);

use constant JSON => 0;
use constant XML  => 1;
use constant ATOM => 2;

1;

=head1 NAME

Net::OpenSocial::Client::Type::Format - Constans for format-type

=head1 SYNOPSIS

    use Net::OpenSocial::Client::Type::Auth qw(JSON XML ATOM);
    say JSON;
    say XML;
    say ATOM;

=head1 DESCRIPTION

Constants for format-type.
But current version of Net-OpenSocial-Client doesn't support XML and ATOM format.

=head1 VALUES

=over 4

=item JSON

use JSON encoder/decoder.
See L<Net::OpenSocial::Client::Formatter::JSON> for more detail.

=item XML

use XML encoder/decoder.
Now not supported.

=item ATOM

Atom Syndication Format.
Now not supported.

=back

=head1 AUTHOR

Lyo Kato, E<lt>lyo.kato@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Lyo Kato

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut

