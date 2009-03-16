package Net::OpenSocial::Client::AuthMethod::ST;

use Any::Moose;

has 'st' => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

sub sign {

}


sub params {
    my $self = shift;
    return { st => $self->st };
}

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

