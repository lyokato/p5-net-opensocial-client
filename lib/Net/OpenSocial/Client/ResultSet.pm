package Net::OpenSocial::Client::ResultSet;

use Any::Moose;
use Any::Moose 'X::AttributeHelpers';

has 'results' => (
    is  => 'ro',
    isa => 'HashRef',
    default => sub { +{} },
    metaclass => 'Collection::Hash',
    provides => {
        set => 'set_result',
        get => 'get_result',
    },
);

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

=head1 NAME

Net::OpenSocial::Client::ResultSet - Set of result

=head1 SYNOPSIS

    my $result_set = Net::OpenSocial::Client::ResultSet->new;
    $result_set->set_result( $request1_id => $result1 );
    $result_set->set_result( $request2_id => $result2 );

    my $result = $result_set->get_result( $request1_id );
    if ( $result->is_error ) {
        ...
    }
    ...

=head1 DESCRIPTION

Set of result.

=head1 METHODS

=head2 results

Hash reference that contains some of pairs of request-id and result.

=head2 get_result( $request_id )

Get the L<Net::OpenSocial::Client::Result> object for the request-id indicated.

=head2 set_result( $request_id => $result )

Set the L<Net::OpenSocial::Client::Result> object with request-id.

=head1 SEE ALSO

L<Net::OpenSocial::Client::Result>

=head1 AUTHOR

Lyo Kato, E<lt>lyo.kato@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Lyo Kato

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut

