package Net::OpenSocial::Client::Request::FetchPeople;

use Any::Moose;
extends 'Net::OpenSocial::Client::Request';

use Net::OpenSocial::Client::Type::Service qw(PEOPLE);
use Net::OpenSocial::Client::Type::Operation qw(GET);

around 'new' => sub {
    my ( $next, $class, $user_id, $group_id, $params ) = @_;
    my %args;
    $args{service}   = PEOPLE;
    $args{operation} = GET;
    $args{user_id}   = $user_id  || '@me';
    $args{group_id}  = $group_id || '@self';
    $args{params}    = $params;
    $next->($class, %args);
};

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;


