package Net::OpenSocial::Client::ErrorHandler;

use Any::Moose '::Role';

has '_errstr' => (
    is => 'rw',
    isa => 'Str',
);

sub ERROR {
    my ( $self, $message ) = @_;
    $self->_errstr($message);
}

sub errstr {
    my $self = shift;
    return $self->_errstr;
}


1;


