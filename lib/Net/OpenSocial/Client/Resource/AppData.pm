package Net::OpenSocial::Client::Resource::AppData;

use Any::Moose;
extends 'Net::OpenSocial::Client::Resource';

use Net::OpenSocial::Client::Type::Service qw(APPDATA);

has '+service' => (
    is      => 'ro',
    isa     => 'Str',
    default => APPDATA,
);

sub get_user_ids {
    my $self = shift;
    return keys %{ $self->fields };
}

sub get_data {
    my ( $self, $user_id, $key ) = @_;
    if ( exists $self->fields->{$user_id}
        && $self->fields->{$user_id}{$key} )
    {
        return $self->fields->{$user_id}{$key};
    }
}

sub set_data {
    my ( $self, $user_id, $key, $value ) = @_;
    unless ( exists $self->fields->{$user_id} ) {
        $self->fields->{$user_id} = {};
    }
    $self->fields->{$user_id}{$key} = $value;
}

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

