package Net::OpenSocial::Client::Type::Operation;

use strict;
use warnings;

use base 'Exporter';

our @EXPORT_OK = qw(GET CREATE UPDATE DELETE);

use constant GET    => 'get';
use constant CREATE => 'create';
use constant UPDATE => 'update';
use constant DELETE => 'delete';

1;


