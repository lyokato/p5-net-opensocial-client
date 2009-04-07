use strict;
use Test::More tests => 3;

use Net::OpenSocial::Client;
use Net::OpenSocial::Client::Type::Protocol qw(RPC REST);
use Net::OpenSocial::Client::Type::Format qw(JSON XML);
use Net::OpenSocial::Client::Request::FetchPeople;
use Net::OpenSocial::Client::Request::FetchPerson;
use Net::OpenSocial::Client::Request::FetchFriends;
use Net::OpenSocial::Client::Container::OrkutSandbox;
use Net::OpenSocial::Client::Agent::Dump;
use OAuth::Lite::Consumer;

my $client = Net::OpenSocial::Client->new(
    #agent           => Net::OpenSocial::Client::Agent::Dump->new,
    container       => Net::OpenSocial::Client::Container::OrkutSandbox->new,
    consumer_key    => q{orkut.com:623061448914},
    consumer_secret => q{uynAeXiWTisflWX99KU1D2q5},
    requestor       => q{03067092798963641994},
    #protocol_type  => RPC,
    #auth_type      => ST,
);

my $req
    = Net::OpenSocial::Client::Request::FetchFriends->new( '03067092798963641994');
$client->add_request( hogehoge => $req );
my $req2
#= Net::OpenSocial::Client::Request::FetchPerson->new( '03067092798963641994');
    = Net::OpenSocial::Client::Request::FetchPerson->new( '030670927989636419944');
$client->add_request( hogehoge2 => $req2 );
my $resultset = $client->send();
ok($resultset);
my $result1 = $resultset->get_result('hogehoge');
ok($result1);
my $result2 = $resultset->get_result('hogehoge2');
ok($result2);


