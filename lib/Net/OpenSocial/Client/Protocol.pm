package Net::OpenSocial::Client::Protocol;

use Any::Moose;
use Any::Moose 'X::AttributeHelpers';

use LWP::UserAgent;

has 'formatter' => (
    is       => 'ro',
    required => 1,

    # does => 'Net::OpenSocial::Client::Formatter',
);

has 'auth_method' => (
    is       => 'ro',
    required => 1,

    # does => 'Net::OpenSocial::Client::AuthMethod',
);

has 'agent' => (
    is       => 'ro',
    required => 1,
    default  => sub { LWP::UserAgent->new },
);

has '_requests' => (
    is        => 'ro',
    isa       => 'ArrayRef[Net::OpenSocial::Client::Request]',
    default   => sub { [] },
    metaclass => 'Collection::Array',
    provides  => {
        empty => 'clear_requests',
        push  => 'add_request',
    },
);

sub execute {
    my ( $self, $container ) = @_;
    die "abstract method";
}

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

