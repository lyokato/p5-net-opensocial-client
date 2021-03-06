package Net::OpenSocial::Client::Protocol::Builder;

use Any::Moose;

use OAuth::Lite::Token;

use Net::OpenSocial::Client::HTTPRequestBuilder::OAuth;
use Net::OpenSocial::Client::HTTPRequestBuilder::ST;

use Net::OpenSocial::Client::Protocol::REST;
use Net::OpenSocial::Client::Protocol::RPC;

use Net::OpenSocial::Client::Formatter::JSON;

use Net::OpenSocial::Client::Type::Protocol qw(REST RPC);
use Net::OpenSocial::Client::Type::Auth qw(OAUTH ST);
use Net::OpenSocial::Client::Type::Format qw(JSON XML ATOM);

with 'Net::OpenSocial::Client::ErrorHandler';

has 'protocol_type' => (
    is      => 'ro',
    isa     => 'Str',
    default => REST,
);

has 'auth_type' => (
    is      => 'ro',
    isa     => 'Str',
    default => OAUTH,
);

has 'format_type' => (
    is      => 'ro',
    isa     => 'Str',
    default => JSON,
);

has 'consumer_key' => (
    is  => 'ro',
    isa => 'Str',
);

has 'consumer_secret' => (
    is  => 'ro',
    isa => 'Str',
);

has 'token' => (
    is  => 'ro',
    isa => 'OAuth::Lite::Token',
);

has 'requestor' => (
    is  => 'ro',
    isa => 'Str',
);

has 'st' => (
    is  => 'ro',
    isa => 'Str',
);

has 'agent' => (
    is      => 'ro',
    default => sub { LWP::UserAgent->new },
);

sub build_protocol {
    my $self            = shift;
    my $request_builder = $self->_build_request_builder()
        or return;
    my $formatter = $self->_build_formatter()
        or return;
    if ( $self->protocol_type eq REST ) {
        return Net::OpenSocial::Client::Protocol::REST->new(
            request_builder => $request_builder,
            formatter       => $formatter,
            agent           => $self->agent,
        );
    }
    elsif ( $self->protocol_type eq RPC ) {
        return Net::OpenSocial::Client::Protocol::RPC->new(
            request_builder => $request_builder,
            formatter       => $formatter,
            agent           => $self->agent,
        );
    }
    return $self->ERROR(q{Unknown protocol type.});
}

sub _build_formatter {
    my $self = shift;
    if ( $self->format_type eq JSON ) {
        return Net::OpenSocial::Client::Formatter::JSON->new;
    }

    # XXX: not supported yet
    #elsif ( $self->format_type eq XML ) {
    #    return Net::OpenSocial::Client::Formatter::XML->new;
    #}
    #elsif ( $self->format_type eq ATOM ) {
    #    return $self->ERROR(q{Atom format is not supported on RPC protocol.})
    #        if ( $self->protocol_type eq RPC );
    #    return Net::OpenSocial::Client::Formatter::Atom->new;
    #}
    return $self->ERROR(q{Unknown format type.});
}

sub _build_request_builder {
    my $self = shift;
    if ( $self->auth_type eq OAUTH ) {
        return $self->ERROR(
            q{When you set OAUTH as auth_type, you should set both 'consumer_key' and 'consumer_secret'.}
            )
            unless ( defined $self->consumer_key
            && defined $self->consumer_secret );
        my %args = (
            consumer_key    => $self->consumer_key,
            consumer_secret => $self->consumer_secret,
        );
        if ( $self->token ) {
            $args{token} = $self->token;
        }
        elsif ( $self->requestor ) {
            $args{requestor} = $self->requestor;
        }
        return Net::OpenSocial::Client::HTTPRequestBuilder::OAuth->new(%args);
    }
    elsif ( $self->auth_type eq ST ) {
        return $self->ERROR(
            q{When you set ST as auth_type, you should set parameter 'st' for security token value.}
        ) unless ( defined $self->st );
        return Net::OpenSocial::Client::HTTPRequestBuilder::ST->new(
            st => $self->st );
    }
    return $self->ERROR(q{Unknown auth type.});
}

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

=head1 NAME

Net::OpenSocial::Client::Protocol::Builder - Protocol builder

=head1 SYNOPSIS

    my $builder = Net::OpenSocial::Client::Protocol::Builder->new();
    my $protocol = $builder->build_protocol();

=head1 DESCRIPTION

Protocol builder.

=head1 METHODS

=head2 build_protocol

=head1 SEE ALSO

L<Net::OpenSocial::Client>
L<Net::OpenSocial::Client::Protocol>
L<Net::OpenSocial::Client::Protocol::REST>
L<Net::OpenSocial::Client::Protocol::RPC>

=head1 AUTHOR

Lyo Kato, E<lt>lyo.kato@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Lyo Kato

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut
