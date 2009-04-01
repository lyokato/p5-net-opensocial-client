package Net::OpenSocial::Client::HTTPRequestBuilder;

use Any::Moose '::Role';

requires qw(build_request);

1;

=head1 NAME

Net::OpenSocial::Client::HTTPRequestBuilder - HTTP request builder role

=head1 SYNOPSIS

    package MyBuilder;
    use Any::Moose;
    with 'Net::OpenSocial::Client::HTTPRequestBuilder';
    
    sub build_request {
        ...
    }

=head1 DESCRIPTION

Build a HTTP::Request object.

=head1 METHODS

=head2 build_request

Interface.
Implement this method in a class which adopts this role.

=head1 AUTHOR

Lyo Kato, E<lt>lyo.kato@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Lyo Kato

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut

