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

=pod
sub _get_fields_for_version {

}

sub _setup_accessors_for_version {
    my ( $self, $version ) = @_;
    my $class = ref $self;
    my $fields = $self->_get_fields_for_version($version);
    for my $field ( @$fields ) {
        if ( Data::Util::is_string($field) ) {
            Data::Util::install_subroutine( $class, $field => sub {
                my ( $self, $value ) = @_;
                $self->set_field( $field, $value ) if defined $value;
                return $self->get_field( $field );
            } );
        } elsif ( Data::Util::is_array_ref($field) ) {
            $self->set_field( $field => Net::OpenSocial::Client::Resource->new );
            Data::Util::install_subroutine( $class, $field => sub {
                my $self = shift;
                return $self->get_field( $field );
            } );
        }
    }
}
=cut

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

=head1 SYNOPSIS


=cut
