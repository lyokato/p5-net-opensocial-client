package Net::OpenSocial::Client::Container::Partuza;

use Any::Moose;
extends 'Net::OpenSocial::Client::Container';

sub BUILDARGS {
    my ( $self, @args ) = @_;
    return {
        request_token_path    => q{http://www.partuza.nl/oauth/request_token},
        authorize_path        => q{http://www.partuza.nl/oauth/request_token},
        access_token_path     => q{http://www.partuza.nl/oauth/access_token},
        rest_endpoint         => q{http://modules.partuza.nl/social/rest},
        use_request_body_hash => 1,
    };
}

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

