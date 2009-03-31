package Net::OpenSocial::Client::ErrorHandler;

use Any::Moose '::Role';

has '_errstr' => (
    is => 'rw',
    isa => 'Str',
);

sub ERROR {
    my ( $self, $message ) = @_;
    $self->_errstr($message);
    return;
}

sub errstr {
    my $self = shift;
    return $self->_errstr;
}

1;

=head1 NAME

Net::OpenSocial::Client::ErrorHandler - Error handler role

=head1 SYNOPSIS

    package MyClass;
    use Any::Moose;
    with 'Net::OpenSocial::Client::ErrorHandler';
    sub my_method {
        my $self = shift;
        if ( $self->found_any_error ) {
            return $self->ERROR('Error occured.');
        }
        return 1;
    }

    package main;
    use MyClass;
    my $foo = MyClass->new;
    my $result = $foo->my_method
        or die $foo->errstr;

=head1 DESCRIPTION

Error handler role.
This provides a simple way to handle error.

=head1 METHODS

=head2 ERROR( $message )

When some error occured, call like that

    return $self->ERROR($error_message);

And this returns undef.
After that, you can pick up the error message by calling 'errstr' method.

=head2 errstr

If it already called 'ERROR' method, it returns an error message.

    die $self->errstr;

=head1 SEE ALSO

L<Class::ErrorHandler>

=head1 AUTHOR

Lyo Kato, E<lt>lyo.kato@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Lyo Kato

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut

