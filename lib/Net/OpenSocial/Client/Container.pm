package Net::OpenSocial::Client::Container;

use Any::Moose;

has 'rest_endpoint' => (
    is  => 'ro',
    isa => 'Str',
);

has 'rpc_endpoint' => (
    is  => 'ro',
    isa => 'Str',
);

has 'use_request_body_hash' => (
    is      => 'ro',
    isa     => 'Bool',
    default => 0,
);

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

