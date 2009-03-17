package Net::OpenSocial::Client::Type::Service;

use strict;
use warnings;

use base 'Exporter';

our @EXPORTER = qw(PEOPLE GROUP ACTIVITY APPDATA);

use constant PEOPLE   => 'people';
use constant GROUP    => 'groups';
use constant ACTIVITY => 'activities';
use constant APPDATA  => 'appdata';

1;

