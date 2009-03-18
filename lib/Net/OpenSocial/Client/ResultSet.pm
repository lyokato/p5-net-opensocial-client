package Net::OpenSocial::Client::ResultSet;

use Any::Moose;
use Any::Moose 'X::AttributeHelpers';

has 'results' => (
    is  => 'ro',
    isa => 'HashRef',
    metaclass => 'Collection::Hash',
    provides => {
        set => 'set_result',
        get => 'get_result',
    },
);

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;


