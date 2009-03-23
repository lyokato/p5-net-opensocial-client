use strict;
use warnings;

use Test::More tests => 19; 

BEGIN {

use_ok("Net::OpenSocial::Client::Formatter");
use_ok("Net::OpenSocial::Client::Formatter::JSON");
use_ok("Net::OpenSocial::Client::Formatter::XML");

use_ok("Net::OpenSocial::Client::HTTPRequestBuilder");
use_ok("Net::OpenSocial::Client::HTTPRequestBuilder::ST");
use_ok("Net::OpenSocial::Client::HTTPRequestBuilder::HMAC");

use_ok("Net::OpenSocial::Client::Result");
use_ok("Net::OpenSocial::Client::Collection");

use_ok("Net::OpenSocial::Client::Resource");
use_ok("Net::OpenSocial::Client::Resource::Factory");
use_ok("Net::OpenSocial::Client::Resource::Person");
use_ok("Net::OpenSocial::Client::Resource::Group");
use_ok("Net::OpenSocial::Client::Resource::Activity");
use_ok("Net::OpenSocial::Client::Resource::AppData");

use_ok("Net::OpenSocial::Client::Protocol");
use_ok("Net::OpenSocial::Client::Protocol::RPC");
use_ok("Net::OpenSocial::Client::Protocol::REST");
use_ok("Net::OpenSocial::Client::Protocol::Builder");

use_ok("Net::OpenSocial::Client");

};

