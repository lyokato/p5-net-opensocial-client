package Net::OpenSocial::Client::Resource::Group;

use Any::Moose;
extends 'Net::OpenSocial::Client::Resource';

use Net::OpenSocial::Client::Type::Service qw(GROUP);

has '+service' => (
    is      => 'ro',
    isa     => 'Str',
    default => GROUP,
);

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;


