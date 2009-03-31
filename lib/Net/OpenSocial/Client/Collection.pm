package Net::OpenSocial::Client::Collection;

use Any::Moose;
use Any::Moose 'X::AttributeHelpers';

has 'start_index' => (
    is      => 'rw',
    isa     => 'Int',
    default => 0,
);

has 'items_per_page' => (
    is  => 'rw',
    isa => 'Int',
);

has 'total_results' => (
    is      => 'rw',
    isa     => 'Int',
    default => 0,
);

has 'items' => (
    is        => 'ro',
    isa       => 'ArrayRef[Net::OpenSocial::Client::Resource]',
    default   => sub { [] },
    metaclass => 'Collection::Array',
    provides  => {
        count  => 'count',
        first  => 'first',
        'push' => 'add_item',
    },
);

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

=head1 NAME

Net::OpenSocial::Client::Collection - Collection of resources

=head1 SYNOPSIS

=head1 DESCRIPTION

Collection of resources.

=head1 METHODS

=head2 items_per_page

=head2 total_results

=head2 start_index

=head2 items

=head2 add_item

=head2 count

=head2 first

=head1 SEE ALSO

L<Net::OpenSocial::Client::Resource>

=head1 AUTHOR

Lyo Kato, E<lt>lyo.kato@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Lyo Kato

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut
