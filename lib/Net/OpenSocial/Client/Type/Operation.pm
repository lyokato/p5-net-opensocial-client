package Net::OpenSocial::Client::Type::Operation;

use strict;
use warnings;

use base 'Exporter';

our @EXPORT_OK = qw(GET CREATE UPDATE DELETE);

use constant GET    => 'get';
use constant CREATE => 'create';
use constant UPDATE => 'update';
use constant DELETE => 'delete';

1;

=head1 NAME

Net::OpenSocial::Client::Type::Operation - Constants for operation-type

=head1 SYNOPSIS

    use Net::OpenSocial::Client::Type::Operation qw(GET CREATE UPDATE DELETE);
    say GET;
    say CREATE;
    say UPDATE;
    say DELETE;

=head1 DESCRIPTION

Constants for operation-type

=head1 VALUES

=over 4

=item GET

=item CREATE

=item UPDATE

=item DELETE

=back

=head1 AUTHOR

Lyo Kato, E<lt>lyo.kato@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Lyo Kato

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut

