package Net::OpenSocial::Client::Activity;

use Any::Moose;
extends 'Net::OpenSocial::Client::Resource';

use Net::OpenSocial::Client::Type::Service qw(ACTIVITY);

has '+service' => (
    is      => 'ro',
    isa     => 'Str',
    default => ACTIVITY,
);

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;
