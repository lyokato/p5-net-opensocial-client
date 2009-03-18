package Net::OpenSocial::Client::Type::Service;

use strict;
use warnings;

use base 'Exporter';

our @EXPORT_OK = qw(PEOPLE GROUP ACTIVITY APPDATA);

use constant PEOPLE   => 'people';
use constant GROUP    => 'groups';
use constant ACTIVITY => 'activities';
use constant APPDATA  => 'appdata';

1;

