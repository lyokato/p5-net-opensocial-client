package Net::OpenSocial::Client::Request;

use Any::Moose;

has 'service' => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

has 'operation' => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

has 'params' => (
    is  => 'ro',
    isa => 'HashRef',
);

has 'resource' => (
    is => 'ro',
    isa => 'Net::OpenSocial::Client::Resource',
);

my %OP_METHOD_MAP = (
    get    => 'GET',
    create => 'POST',
    update => 'PUT',
    delete => 'DELETE',
);

sub rpc_service {
    my $self    = shift;
    my $service = $self->service;
    $service = 'activities' if $service eq 'activity';
    return $service;
}

sub http_method_for_operation {
    my $self = shift;
    return $OP_METHOD_MAP{ $self->operation };
}

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

