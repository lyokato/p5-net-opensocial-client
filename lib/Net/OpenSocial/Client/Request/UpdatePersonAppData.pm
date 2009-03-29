package Net::OpenSocial::Client::Request::UpdatePersonAppData;

use Any::Moose;
extends 'Net::OpenSocial::Client::Request';

use Net::OpenSocial::Client::Type::Service qw(APPDATA);
use Net::OpenSocial::Client::Type::Operation qw(UPDATE);

sub BUILDARGS {
    my ( $self, $user_id, $resource, $params ) = @_;
    $params ||= {};
    $params->{appId} = '@app';
    my $args = {
        service   => APPDATA,
        operation => UPDATE,
        user_id   => $user_id || '@me',
        group_id  => '@self',
        params    => $params,
    };
    $args->{resource} = $resource if $resource;
    return $args;
}

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

