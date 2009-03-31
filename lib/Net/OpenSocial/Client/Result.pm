package Net::OpenSocial::Client::Result;

use Any::Moose;

has 'is_error' => (
    is      => 'ro',
    isa     => 'Bool',
    default => 0,
);

has 'code' => (
    is  => 'ro',
    isa => 'Int',
);

has 'message' => (
    is  => 'ro',
    isa => 'Str',
);

has 'data' => ( is => 'ro', );

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

=head1 NAME

Net::OpenSocial::Client::Result - Result of REST/RPC request

=head1 SYNOPSIS

    my $result = $result_set->get_result( $request_id );
    if ( $result->is_error ) {
        say $result->code;
        say $result->message;
    } else {
        my $data = $result->data;
    }

=head1 DESCRIPTION

Result of REST/RPC request.

=head1 METHODS

=head2 is_error

Boolean that represents if the request successfuly got response.

=head2 code

HTTP status code.

=head2 message

HTTP status message

=head2 data

Returns a resource or collection of resources.
See L<Net::OpenSocial::Client::Resource> and its subclasses,
and L<Net::OpenSocial::Client::Collection>.

=head1 AUTHOR

Lyo Kato, E<lt>lyo.kato@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Lyo Kato

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut

