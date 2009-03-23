package Net::OpenSocial::Client::Result;

use Any::Moose;

has 'is_error' => (
    is      => 'ro',
    isa     => 'Bool',
    default => 0,
);

has 'code' => (
    is  => 'ro',
    isa => 'Int',
);

has 'message' => (
    is  => 'ro',
    isa => 'Str',
);

has 'data' => ( is => 'ro', );

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

