package Net::OpenSocial::Client::Type::Service;

use strict;
use warnings;

use base 'Exporter';

our @EXPORT_OK = qw(PEOPLE GROUP ACTIVITY APPDATA ALBUM MEDIAITEM);

use constant PEOPLE    => 'people';
use constant GROUP     => 'groups';
use constant ACTIVITY  => 'activities';
use constant APPDATA   => 'appdata';
use constant ALBUM     => 'albums';
use constant MEDIAITEM => 'mediaitems';

1;

=head1 NAME

Net::OpenSocial::Client::Type::Service - Constants for service-type

=head1 SYNOPSIS

    use Net::OpenSocial::Client::Type::Service qw(PEOPLE GROUP ACTIVITY APPDATA ALBUM MEDIAITEM);
    say PEOPLE;
    say GROUP;
    say ACTIVITY;
    say APPDATA;
    say ALBUM;
    say MEDIAITEM;

=head1 DESCRIPTION

Constants for service-type

=head1 VALUES

=over 4

=item PEOPLE

=item GROUP

=item ACTIVITY

=item APPDATA

=item ALBUM

=item MEDIAITEM

=back

=head1 AUTHOR

Lyo Kato, E<lt>lyo.kato@gmail.comE<gt>, OpenSocial 0.9 "album" and "mediaItem" 
services added by Eugene A.Lukianov, E<lt>eugene.spa@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Lyo Kato

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut

