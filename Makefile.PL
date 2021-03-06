use strict;
use warnings;

use inc::Module::Install;

name 'Net-OpenSocial-Client';
all_from 'lib/Net/OpenSocial/Client.pm';

requires(
    'Any::Moose'               => '0.06',
    'OAuth::Lite'              => '1.17',
    'URI'                      => 0,
    'HTTP::Request'            => 0,
    'HTTP::Headers'            => 0,
    'LWP::UserAgent'           => 0,
    'JSON'                     => '2.14',
    'Mouse'                    => '0.21',
    'MouseX::AttributeHelpers' => '0.03',
    'Data::Dump'               => 0,
);

tests('t/*.t t/*/*.t');

author_tests('xt');

test_requires(
    'Test::More'                   => 0,
    'Module::Install::AuthorTests' => 0,
    'Test::LoadAllModules'         => '0.02'
);

auto_include;
WriteAll;
