package Net::OpenSocial::Client::Resource::Activity;

use Any::Moose;
extends 'Net::OpenSocial::Client::Resource';

use Net::OpenSocial::Client::Type::Service qw(ACTIVITY);

has '+service' => (
    default => ACTIVITY,
);

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

=head1 NAME

Net::OpenSocial::Client::Resource::Activity - activity

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHODS

=head1 SEE ALSO

L<Net::OpenSocial::Client::Resource>
L<Net::OpenSocial::Client::Resource::Factory>
L<Net::OpenSocial::Client::Resource::Person>
L<Net::OpenSocial::Client::Resource::Group>
L<Net::OpenSocial::Client::Resource::AppData>

=head1 AUTHOR

Lyo Kato, E<lt>lyo.kato@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Lyo Kato

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut

