package Net::OpenSocial::Client::Container::Partuza;

use Any::Moose;
extends 'Net::OpenSocial::Client::Container';

sub BUILDARGS {
    my ( $self, @args ) = @_;
    return {
        request_token_endpoint    => q{http://www.partuza.nl/oauth/request_token},
        authorize_endpoint        => q{http://www.partuza.nl/oauth/request_token},
        access_token_endpoint     => q{http://www.partuza.nl/oauth/access_token},
        rest_endpoint             => q{http://modules.partuza.nl/social/rest},
        use_request_body_hash     => 1,
    };
}

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

=head1 NAME

Net::OpenSocial::Client::Container::Partuza - partuza

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


