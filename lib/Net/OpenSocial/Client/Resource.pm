package Net::OpenSocial::Client::Resource;

use Any::Moose;
use Any::Moose 'X::AttributeHelpers';

has 'service' => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

has 'fields' => (
    is        => 'ro',
    isa       => 'HashRef',
    default   => sub { +{} },
    metaclass => 'Collection::Hash',
    provides  => {
        get => 'get_field',
        set => 'set_field',
    },
);

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

