package Net::OpenSocial::Client::Container;

use Any::Moose;

has 'endpoint' => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

has 'rest' => (
    is  => 'ro',
    isa => 'Str',
);

has 'rpc' => (
    is  => 'ro',
    isa => 'Str',
);

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

