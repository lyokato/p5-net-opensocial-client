package Net::OpenSocial::Client::Request;

use Any::Moose;

has 'id' => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

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

has 'user_id' => (
    is      => 'ro',
    isa     => 'Str',
    default => '@me',
);

has 'group_id' => (
    is      => 'ro',
    isa     => 'Str',
    default => '@self',
);

has 'params' => (
    is  => 'ro',
    isa => 'HashRef',
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
    is  => 'ro',
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

