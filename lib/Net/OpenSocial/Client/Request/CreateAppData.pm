package Net::OpenSocial::Client::Request::CreateAppData;

use Any::Moose;
extends 'Net::OpenSocial::Client::Request';

use Net::OpenSocial::Client::Type::Service qw(APPDATA);
use Net::OpenSocial::Client::Type::Operation qw(CREATE);

sub BUILDARGS {
    my ( $self, $user_id, $group_id, $app_id, $resource, $params ) = @_;
    $params ||= {};
    $params->{appId} = $app_id if $app_id;
    my $args = {
        service   => APPDATA,
        operation => CREATE,
        user_id   => $user_id || '@me',
        group_id  => $group_id || '@self',
        params    => $params,
    };
    $args->{resource} = $resource if $resource;
    return $args;
}

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

