package Net::OpenSocial::Client::Container::Google;

use Any::Moose;
extends 'Net::OpenSocial::Client::Container';

sub BUILDARGS {
    my ( $self, @args ) = @_;
    return {
        rest_endpoint =>
            q{http://www-opensocial-sandbox.googleusercontent.com/api/},
        rpc_endpoint =>
            q{http://www-opensocial-sandbox.googleusercontent.com/api/rpc},
        use_request_body_hash => 1,
    };
}

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

