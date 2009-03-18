package Net::OpenSocial::Client::Formatter;

use Any::Moose '::Role';

has 'content_type' => (
    is  => 'ro',
    isa => 'Str',
);

has 'name' => (
    is  => 'ro',
    isa => 'Str',
);

requires qw(encode decode);

1;

