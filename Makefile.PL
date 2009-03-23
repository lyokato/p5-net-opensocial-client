use strict;
use warnings;

use inc::Module::Install;

name 'Net-OpenSocial-Client';
all_from 'lib/Net/OpenSocial/Client.pm';

requires(
    'Any::Moose'    => 0,
    'OAuth::Lite'   => 0,
    'HTTP::Request' => 0,
    'JSON::XS'      => 0,
);

tests('t/*.t t/*/*.t');

#author_tests('xt');
test_requires(
    'Test::More'  => 0,
    'Test::Class' => 0,
);

auto_include;
WriteAll;
