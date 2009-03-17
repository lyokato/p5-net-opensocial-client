package Net::OpenSocial::Client::Type::Format;

use strict;
use warnings;

use base 'Exporter';

our @EXPORT_OK = qw(JSON XML ATOM);

use constant JSON => 0;
use constant XML  => 1;
use constant ATOM => 2;

1;


