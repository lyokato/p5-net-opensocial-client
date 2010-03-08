package Net::OpenSocial::Client::Resource::Factory;

use Any::Moose;
use Net::OpenSocial::Client::Type::Service qw(PEOPLE GROUP ACTIVITY APPDATA ALBUM MEDIAITEM);

use Net::OpenSocial::Client::Resource::Person;
use Net::OpenSocial::Client::Resource::Activity;
use Net::OpenSocial::Client::Resource::AppData;
use Net::OpenSocial::Client::Resource::Group;
use Net::OpenSocial::Client::Resource::Album;
use Net::OpenSocial::Client::Resource::MediaItem;

sub gen_resource {
    my ( $class, $service, $data ) = @_;
    if ( $service eq PEOPLE ) {
        return Net::OpenSocial::Client::Resource::Person->new(
            fields => $data );
    }
    elsif ( $service eq GROUP ) {
        return Net::OpenSocial::Client::Resource::Group->new(
            fields => $data );
    }
    elsif ( $service eq ACTIVITY ) {
        return Net::OpenSocial::Client::Resource::Activity->new(
            fields => $data );
    }
    elsif ( $service eq APPDATA ) {
        return Net::OpenSocial::Client::Resource::AppData->new(
            fields => $data );
    }
    elsif ( $service eq ALBUM ) {
        return Net::OpenSocial::Client::Resource::Album->new(
            fields => $data );
    }
    elsif ( $service eq MEDIAITEM ) {
        return Net::OpenSocial::Client::Resource::MediaItem->new(
            fields => $data );
    }
}

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

=head1 NAME

Net::OpenSocial::Client::Resource::Factory - resource factory

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHODS

=head2 gen_resource

=head1 SEE ALSO

L<Net::OpenSocial::Client::Resource>
L<Net::OpenSocial::Client::Resource::Person>
L<Net::OpenSocial::Client::Resource::Group>
L<Net::OpenSocial::Client::Resource::AppData>
L<Net::OpenSocial::Client::Resource::Activity>
L<Net::OpenSocial::Client::Resource::Album>
L<Net::OpenSocial::Client::Resource::MediaItem>

=head1 AUTHOR

Lyo Kato, E<lt>lyo.kato@gmail.comE<gt>, OpenSocial 0.9 "album" and "mediaItem"
services added by Eugene A.Lukianov, E<lt>eugene.spa@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Lyo Kato

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut

