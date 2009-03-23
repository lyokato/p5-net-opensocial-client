package Net::OpenSocial::Client::Resource::Person;

use Any::Moose;
extends 'Net::OpenSocial::Client::Resource';

use Net::OpenSocial::Client::Type::Service qw(PEOPLE);

has '+service' => (
    is      => 'ro',
    isa     => 'Str',
    default => PEOPLE,
);

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;


