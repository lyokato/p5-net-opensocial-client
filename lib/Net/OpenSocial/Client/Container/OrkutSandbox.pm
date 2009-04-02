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

