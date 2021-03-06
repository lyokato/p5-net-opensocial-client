package Net::OpenSocial::Client::Request::FetchFriends;

use Any::Moose;
extends 'Net::OpenSocial::Client::Request';

use Net::OpenSocial::Client::Type::Service qw(PEOPLE);
use Net::OpenSocial::Client::Type::Operation qw(GET);

sub BUILDARGS {
    my ( $self, $user_id, $params ) = @_;
    return {
        service   => PEOPLE,
        operation => GET,
        user_id   => $user_id||'@me',
        group_id  => '@friends',
        params    => $params||{},
    };
}

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

=head1 NAME

Net::OpenSocial::Client::Request::FetchFriends - Request to fetch friends

=head1 SYNOPSIS

    my $user_id = '@me';
    my $req = Net::OpenSocial::Client::Request::FetchFriends->new( $user_id );
    $client->add_request( $req_id => $req );

=head1 DESCRIPTION

Request to fetch friends which has a simple constructor.
You only have to do is pass a user-id or selector.
This is a subclass of L<Net::OpenSocial::Client::Request>.

=head1 METHODS

=head2 BUILDARGS

See L<Moose> or L<Mouse>

=head1 SEE ALSO

L<Net::OpenSocial::Client::Request>

=head1 AUTHOR

Lyo Kato, E<lt>lyo.kato@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Lyo Kato

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut

