package Net::OpenSocial::Client::Formatter;

use Any::Moose '::Role';

has 'content_type' => (
    is  => 'ro',
    isa => 'Str',
);

has 'name' => (
    is  => 'ro',
    isa => 'Str',
);

requires qw(encode decode);

1;

=head1 NAME 

Net::OpenSocial::Client::Formatter - Formatter role

=head1 SYNOPSIS

    package MyFormatter;
    use Any::Moose;
    with 'Net::OpenSocial::Client::Formatter';

    has '+content_type' => (...);
    has '+name' => (...);

    sub encode {
        ...
    }

    sub decode {
        ...
    }

=head1 DESCRIPTION

This module provides just a interface to encode/decode
resource object.
Implement each methods in concrete classes.

=head1 METHODS

=head2 content_type

Mime type for the format.

=head2 name

Formatter name

=head2 encode

Encode perl object to a formatted string.

=head2 decode

Decode formatted string to perl object.

=head1 AUTHOR

Lyo Kato, E<lt>lyo.kato@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Lyo Kato

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut

