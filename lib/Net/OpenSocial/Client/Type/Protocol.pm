package Net::OpenSocial::Client::Type::Protocol;

use strict;
use warnings;

use base 'Exporter';

our @EXPORT_OK = qw(REST RPC);

use constant REST => 0;
use constant RPC  => 1;

1;


