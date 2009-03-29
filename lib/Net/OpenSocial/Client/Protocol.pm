package Net::OpenSocial::Client::Protocol;

use Any::Moose;

use LWP::UserAgent;

has 'formatter' => (
    is       => 'ro',
    required => 1,
    # does => 'Net::OpenSocial::Client::Formatter',
);

has 'request_builder' => (
    is       => 'ro',
    required => 1,

    # does => 'Net::OpenSocial::Client::HTTPRequestBuilder',
);

has 'agent' => (
    is       => 'ro',
    required => 1,
    default  => sub {
        LWP::UserAgent->new;
    },
);

sub execute {
    my ( $self, $container, $requests ) = @_;
    die "abstract method";
}

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

