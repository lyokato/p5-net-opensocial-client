package Net::OpenSocial::Client::Container::MySpace09;

use Any::Moose;
extends 'Net::OpenSocial::Client::Container';

sub BUILDARGS {
    my ( $self, @args ) = @_;
    return {
        request_token_endpoint => q{http://api.myspace.com/request_token},
        authorize_endpoint     => q{http://api.myspace.com/authorize},
        access_token_endpoint  => q{http://api.myspace.com/access_token},
        rest_endpoint          => q{http://opensocial.myspace.com/roa/09},
    };
}

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

=head1 NAME

Net::OpenSocial::Client::Container::MySpace09 - MySpace OpenSocial v0.9

=head1 SYNOPSIS

    my $client = Net::OpenSocial::Client->new(
      container       => Net::OpenSocial::Client::Container::MySpace09->new,
      consumer_key    => q{consumer},
      consumer_secret => q{secret},
    );
    
    or

    my $container = Net::OpenSocial::Client::Container::MySpace09->new;
    say $container->rest_endpoint; # http://opensocial.myspace.com/roa/09

=head1 DESCRIPTION

Endpoint URLs for MySpace OpenSocial v0.9 interface.

=head1 METHODS

Inherited from Net::OpenSocial::Client::Container.

=head2 BUILDARGS

See L<Moose>, L<Mouse>

=head1 AUTHOR

This module is based on Net::OpenSocial::Client::Container::MySpace by
Lyo Kato, E<lt>lyo.kato@gmail.comE<gt>, updates were done by
Eugene A.Lukianov, E<lt>eugene.spa@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Lyo Kato

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut


