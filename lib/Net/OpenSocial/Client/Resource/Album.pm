package Net::OpenSocial::Client::Resource::Album;

use Any::Moose;
extends 'Net::OpenSocial::Client::Resource';

use Net::OpenSocial::Client::Type::Service qw(ALBUM);

has '+service' => (
    default => ALBUM,
);

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

=head1 NAME

Net::OpenSocial::Client::Resource::Album - album

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHODS

=head1 SEE ALSO

L<Net::OpenSocial::Client::Resource>
L<Net::OpenSocial::Client::Resource::Factory>
L<Net::OpenSocial::Client::Resource::Group>
L<Net::OpenSocial::Client::Resource::AppData>
L<Net::OpenSocial::Client::Resource::Activity>

=head1 AUTHOR

This module is based on Net::OpenSocial::Client::Resource::Person by
Lyo Kato, E<lt>lyo.kato@gmail.comE<gt>, updates were done by
Eugene A.Lukianov, E<lt>eugene.spa@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Lyo Kato

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut

