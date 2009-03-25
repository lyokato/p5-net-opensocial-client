package Net::OpenSocial::Client::Request::GetFriends;

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

