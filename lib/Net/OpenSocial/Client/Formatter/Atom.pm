package Net::OpenSocial::Client::Formatter::Atom;

use Any::Moose;
with 'Net::OpenSocial::Client::Formatter';

has '+content_type' => (
    is      => 'ro',
    isa     => 'Str',
    default => q{application/xml+atom},
);

sub encode {

}

sub decode {

}

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

