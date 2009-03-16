package Net::OpenSocial::Client::Formatter::XML;

use Any::Moose;
with 'Net::OpenSocial::Client::Formatter';

has '+content_type' => (
    is      => 'ro',
    isa     => 'Str',
    default => q{application/xml},
);

has '+name' => (
    is      => 'ro',
    isa     => 'Str',
    default => q{xml},
);

use XML::Simple;

sub encode {
    my ( $self, $obj ) = @_;
    return XML::Simple->new->XMLin( $obj, ForceArray => 1 );
}

sub decode {
    my ( $self, $content ) = @_;
    return XML::Simple->new->XMLout($content);
}

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

