package Net::OpenSocial::Client::Formatter::JSON;

use Any::Moose;
with 'Net::OpenSocial::Client::Formatter';

use JSON::XS;

has '+name' => (
    is      => 'ro',
    isa     => 'Str',
    default => q{json},
);

has '+content_type' => (
    is      => 'ro',
    isa     => 'Str',
    default => q{application/json},
);

sub encode {
    my ( $self, $obj ) = @_;
    my $content = JSON::XS->new->encode($obj);
    return $content;
}

sub decode {
    my ( $self, $content ) = @_;
    my $obj = JSON::XS->new->decode($content);
    return $obj;
}

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

