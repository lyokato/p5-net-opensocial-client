package Net::OpenSocial::Client::Resource;

use Any::Moose;
use Any::Moose 'X::AttributeHelpers';

has 'service' => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

has 'version' => (
    is       => 'ro',
    isa      => 'Str',
    default  => q{0.8.1},
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

=head1 NAME

Net::OpenSocial::Client::Resource - Resource base class.

=head1 SYNOPSIS

    package ConcreteResource;
    use Any::Moose;
    extends 'Net::OpenSocial::Client::Resource';
    ...


    my $cr = ConcreteResource->new;
    $cr->set_field( key1 => 'value1 ');
    $cr->set_field( key2 => 'value2' );

    say $cr->get_field( 'key1' );
    say $cr->get_field( 'key2' );

=head1 DESCRIPTION

Resource base class.
You don't need to use this class directly as long as you dan't
develop new opensocial resource class.

=head1 METHODS

=head2 service

Service name of REST/RPC

=head2 version

OpenSocial protocol version number.

=head2 fields

Hash reference that represents fields of resource.

=head2 get_field( $key )

=head2 set_field( $key => $value )

=head1 SEE ALSO

L<Net::OpenSocial::Client::Resource::Person>
L<Net::OpenSocial::Client::Resource::Group>
L<Net::OpenSocial::Client::Resource::AppData>
L<Net::OpenSocial::Client::Resource::Activity>

=head1 AUTHOR

Lyo Kato, E<lt>lyo.kato@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Lyo Kato

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut

