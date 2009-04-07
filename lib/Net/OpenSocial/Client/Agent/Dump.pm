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

=head1 NAME

Net::OpenSocial::Client::Agent::Dump - Agent for debug

=head1 SYNOPSIS

    my $client = Net::OpenSocial::Client->new(
        agent => Net::OpenSocial::Client::Agent::Dump->new,
        ...
    );

=head1 DESCRIPTION

For debug, this agent dump HTTP::Request and HTTP::Response object
around requesting.
Decorator of LWP::UserAgent.

=head1 request

Interface same as LWP::UserAgent

=head1 AUTHOR

Lyo Kato, E<lt>lyo.kato@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Lyo Kato

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut

