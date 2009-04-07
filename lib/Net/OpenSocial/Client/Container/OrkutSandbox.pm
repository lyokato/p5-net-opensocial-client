package Net::OpenSocial::Client::Container::OrkutSandbox;

use Any::Moose;
extends 'Net::OpenSocial::Client::Container';

sub BUILDARGS {
    my ( $self, @args ) = @_;
    return {
        rest_endpoint         => q{http://sandbox.orkut.com/social/rest},
        rpc_endpoint          => q{http://sandbox.orkut.com/social/rpc},
        use_request_body_hash => 1,
    };
}

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

=head1 NAME

Net::OpenSocial::Client::Container::OrkutSandbox - orkut sandbox

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHODS

=head2 BUILDARGS

See L<Moose>, L<Mouse>

=head1 AUTHOR

Lyo Kato, E<lt>lyo.kato@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Lyo Kato

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut


