package Net::OpenSocial::Client::Agent::Dump;

use Any::Moose;

has '_agent' => (
    is => 'ro',
    default => sub { LWP::UserAgent->new },
);

use Data::Dump qw(dump);

sub request {
    my ($self, $request) = @_;
    warn dump($request);
    my $response = $self->_agent->request($request);
    warn dump($response);
    return $response
}


no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;


