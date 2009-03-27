package Net::OpenSocial::Client::Collection;

use Any::Moose;
use Any::Moose 'X::AttributeHelpers';

has 'start_index' => (
    is      => 'rw',
    isa     => 'Int',
    default => 0,
);

has 'items_per_page' => (
    is  => 'rw',
    isa => 'Int',
);

has 'total_results' => (
    is      => 'rw',
    isa     => 'Int',
    default => 0,
);

has 'items' => (
    is        => 'ro',
    isa       => 'ArrayRef[Net::OpenSocial::Client::Resource]',
    default   => sub { [] },
    metaclass => 'Collection::Array',
    provides  => {
        count  => 'count',
        first  => 'first',
        'push' => 'add_item',
    },
);

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

