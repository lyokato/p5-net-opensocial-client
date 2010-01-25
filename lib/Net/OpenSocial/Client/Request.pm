package Net::OpenSocial::Client::Request;

use Any::Moose;

has 'id' => (
    is  => 'rw',
    isa => 'Str',
);

has 'service' => (
    is       => 'rw',
    isa      => 'Str',
    required => 1,
);

has 'operation' => (
    is       => 'rw',
    isa      => 'Str',
    required => 1,
);

has 'user_id' => (
    is       => 'rw',
    isa      => 'Str',
    default  => '@me',
    required => 1,
);

has 'group_id' => (
    is       => 'rw',
    isa      => 'Str',
    default  => '@self',
    required => 1,
);

has 'params' => (
    is      => 'rw',
    isa     => 'HashRef',
    default => sub { +{} },
);

has 'resource' => (
    is        => 'rw',
    isa       => 'Net::OpenSocial::Client::Resource',
    predicate => 'has_resource',
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

=head1 NAME

Net::OpenSocial::Client::Request - Request class.

=head1 SYNOPSIS

    use Net::OpenSocial::Client::Type::Service qw(PEOPLE, ACTIVITY);
    use Net::OpenSocial::Client::Type::Operation qw(GET CREATE UPDATE DELETE);

    my $req = Net::OpenSocial::Client::Request->new(
        service   => PEOPL,
        operation => GET,
        user_id   => '@me',
        group_id  => '@friends',
        params    => {
            itemsPerPage => 10,
            startIndex   => 11,
        },
    );

=head1 DESCRIPTION

This module represents a OpenSocial REST/RPC request.
For short circuit, there are many request subclasses like
L<Net::OpenSocial::Client::Request::FetchPerson>,
L<Net::OpenSocial::Client::Request::FetchFriends> and so on.

=head1 METHODS

=head2 id

Request id

=head2 service

Service type.
See L<Net::OpenSocial::Client::Type::Service>

=head2 operation

Operation type.
See L<Net::OpenSocial::Client::Type::Operation>

=head2 user_id

Service(container) specific user-id or selector like '@me'

=head2 group_id

Service(container) specific group-id or selector like '@self' or '@friends'

=head2 params

Other parameters

=head2 resource

L<Net::OpenSocial::Client::Resource> object,
This parameter is required when the operation is 'CREATE' or 'UPDATE'

=head2 rpc_service

RPC service name

=head2 http_method_for_operation

HTTP method name for current operation.

=head1 AUTHOR

Lyo Kato, E<lt>lyo.kato@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Lyo Kato

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut

