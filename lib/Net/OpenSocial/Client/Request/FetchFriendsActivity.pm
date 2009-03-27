package Net::OpenSocial::Client::Request::FetchFriendsActivity;

use Any::Moose;
extends 'Net::OpenSocial::Client::Request';

use Net::OpenSocial::Client::Type::Service qw(ACTIVITY);
use Net::OpenSocial::Client::Type::Operation qw(GET);

sub BUILDARGS {
    my ( $self, $user_id, $app_id, $params ) = @_;
    $params ||= {};
    $params->{appId} = $app_id if $app_id;
    return {
        service   => ACTIVITY,
        operation => GET,
        user_id   => $user_id||'@me',
        group_id  => '@friends',
        params    => $params,
    };
}

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

