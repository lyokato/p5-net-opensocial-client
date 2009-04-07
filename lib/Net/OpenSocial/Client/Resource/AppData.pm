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

=head1 NAME

Net::OpenSocial::Client::Resource::AppData - appdata

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHODS

=head2 get_user_ids

    my @ids = $appdata->get_user_ids();

=head2 get_data

    my $value = $appdata->get_data( $user_id, $key );

=head2 set_data

    $appdata->set_data( $user_id, $key, $value );

=head1 SEE ALSO

L<Net::OpenSocial::Client::Resource>
L<Net::OpenSocial::Client::Resource::Factory>
L<Net::OpenSocial::Client::Resource::Person>
L<Net::OpenSocial::Client::Resource::Group>
L<Net::OpenSocial::Client::Resource::Activity>

=head1 AUTHOR

Lyo Kato, E<lt>lyo.kato@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Lyo Kato

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut

