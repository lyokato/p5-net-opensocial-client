package Net::OpenSocial::Client::Request;

use Any::Moose;

has 'id' => (
    is  => 'rw',
    isa => 'Str',
);

has 'service' => (
    is  => 'rw',
    isa => 'Str',
);

has 'operation' => (
    is  => 'rw',
    isa => 'Str',
);

has 'user_id' => (
    is      => 'rw',
    isa     => 'Str',
    default => '@me',
);

has 'group_id' => (
    is      => 'rw',
    isa     => 'Str',
    default => '@self',
);

has 'params' => (
    is      => 'rw',
    isa     => 'HashRef',
    default => sub { +{} },
);

=pod
my @REST_PARAMS = qw(
    count
    filterBy
    filterOp
    filterValue
    format
    fields
    networkDistance
    sortBy
    sortOrder
    startIndex
    updatedSince
);

my @PARAMS = qw(
    auth
    userId
    groupId
    appId
    activityIds
    fields
    count
    statIndex
    startPage
);
=cut

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

