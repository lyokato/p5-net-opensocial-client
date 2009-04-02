package Net::OpenSocial::Client::Container::MySpace;

use Any::Moose;
extends 'Net::OpenSocial::Client::Container';

sub BUILDARGS {
    my ( $self, @args ) = @_;
    return {
        request_token_path => q{http://api.myspace.com/request_token},
        authorize_path     => q{http://api.myspace.com/authorize},
        access_token_path  => q{http://api.myspace.com/access_token},
        rest_endpoint      => q{http://api.myspace.com/v2},
    };
}

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

