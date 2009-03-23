package Net::OpenSocial::Client::AppData;

use Any::Moose;
extends 'Net::OpenSocial::Client::Resource';

use Net::OpenSocial::Client::Type::Service qw(APPDATA);

has '+service' => (
    is      => 'ro',
    isa     => 'Str',
    default => APPDATA,
);

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

