package Net::OpenSocial::Client::Request::RemovePersonAppData;

use Any::Moose;
extends 'Net::OpenSocial::Client::Request';

use Net::OpenSocial::Client::Type::Service qw(APPDATA);
use Net::OpenSocial::Client::Type::Operation qw(DELETE);

sub BUILDARGS {
    my ( $self, $user_id, $params ) = @_;
    $params ||= {};
    $params->{appId} = '@app';
    return {
        service   => APPDATA,
        operation => DELETE,
        user_id   => $user_id || '@me',
        group_id  => '@self',
        params    => $params,
    };
}

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

