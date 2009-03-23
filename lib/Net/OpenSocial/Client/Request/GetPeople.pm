package Net::OpenSocial::Client::Request::GetPeople;

use Any::Moose;
extends 'Net::OpenSocial::Client::Request';

use Net::OpenSocial::Client::Type::Service qw(PEOPLE);
use Net::OpenSocial::Client::Type::Operation qw(GET);

sub BUILDARGS {
    my ( $self, $user_id, $group_id, $params ) = @_;
    $self->service(PEOPLE);
    $self->service(GET);
    $self->user_id( $user_id   || '@me' );
    $self->group_id( $group_id || '@self' );
    $self->params( $params     || {} );
}

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

