package Net::OpenSocial::Client::Request;

use Any::Moose;

has 'id' => (
    is  => 'rw',
    isa => 'Str',
);

has 'service' => (
    is  => 'rw',
    isa => 'Str',
    required => 1,
);

has 'operation' => (
    is  => 'rw',
    isa => 'Str',
    required => 1,
);

has 'user_id' => (
    is      => 'rw',
    isa     => 'Str',
    default => '@me',
    required => 1,
);

has 'group_id' => (
    is      => 'rw',
    isa     => 'Str',
    default => '@self',
    required => 1,
);

has 'params' => (
    is      => 'rw',
    isa     => 'HashRef',
    default => sub { +{} },
);

has 'resource' => (
    is      => 'rw',
    isa     => 'Net::OpenSocial::Client::Resource',
    predict => 'has_resource',
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
    $service = 'activity' if $service eq 'activities';
    return $service;
}

sub http_method_for_operation {
    my $self = shift;
    return $OP_METHOD_MAP{ $self->operation };
}

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

