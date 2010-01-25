package Net::OpenSocial::Client::Protocol;

use Any::Moose;

use LWP::UserAgent;

has 'formatter' => (
    is       => 'ro',
    required => 1,
    does => 'Net::OpenSocial::Client::Formatter',
);

has 'request_builder' => (
    is       => 'ro',
    required => 1,
    does => 'Net::OpenSocial::Client::HTTPRequestBuilder',
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

=head1 NAME

Net::OpenSocial::Client::Protocol - Protocol base class

=head1 SYNOPSIS

    package ConcreteProtocol;
    use Any::Moose;
    exnteds 'Net::OpenSocial::Client::Protocol';

    override 'execute' => sub {
        ...
    };

=head1 DESCRIPTION

Protocol base class.

=head1 METHODS

=head2 formatter

Formatter concrete class object.
See L<Net::OpenSocial::Client::Formatter>

=head2 request_builder

HTTPRequestBuilder concrete class object.
See L<Net::OpenSocial::Client::Protocol::HTTPRequestBuilder>

=head2 agent

HTTP Agent class object.
Set LWP::UserAgent object by default.

=head2 execute($container, $requests)

Execute a protocol, and returns a L<Net::OpenSocial::Client::ResultSet> object
or nothing

    my $result_set = $protocol->execute($container, $requests)
        or die $protocol->errstr;

=head1 SEE ALSO

L<Net::OpenSocial::Client::Protocol::REST>
L<Net::OpenSocial::Client::Protocol::RPC>
L<Net::OpenSocial::Client::Protocol::Builder>

=head1 AUTHOR

Lyo Kato, E<lt>lyo.kato@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Lyo Kato

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut
