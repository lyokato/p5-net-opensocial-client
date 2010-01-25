use strict;
use Test::More tests => 33;

#use Moose;
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
    container       => Net::OpenSocial::Client::Container::OrkutSandbox->new,
    consumer_key    => q{orkut.com:623061448914},
    consumer_secret => q{uynAeXiWTisflWX99KU1D2q5},
    requestor       => q{03067092798963641994},
    protocol_type  => RPC,
    #auth_type      => ST,
);

&raw_api();
&simple_api();

sub raw_api {
    my $req
        = Net::OpenSocial::Client::Request::FetchFriends->new( '@me' );
    $client->add_request( foo => $req );
    my $req2
        = Net::OpenSocial::Client::Request::FetchPerson->new( '@me' );
    $client->add_request( bar => $req2 );

    my $req3
        = Net::OpenSocial::Client::Request::FetchPerson->new( 'invalid' );
    $client->add_request( invalid => $req3 );
        
    my $resultset = $client->send();
    ok($resultset);
    my $result1 = $resultset->get_result('foo');
    ok($result1);
    my $collection = $result1->data;
    is($collection->count, 6);
    is($collection->total_results, 6);
    my $items = $collection->items;
    my $person0 = $items->[0];
    is($person0->get_field('id'), '13314698784882897227');
    ok(!$person0->get_field('isViewer'));
    is($person0->get_field('name')->{familyName}, 'Roomann-Kurrik');
    is($person0->get_field('name')->{givenName}, 'Arne');
    is($person0->get_field('thumbnailUrl'), 'http://img2.orkut.com/images/small/1195663673/115231346.jpg');
    my $result2 = $resultset->get_result('bar');
    ok($result2);
    my $person = $result2->data->first;
    ok($person);
    is($person->get_field('id'), '03067092798963641994');
    ok($person->get_field('isViewer'));
    is($person->get_field('name')->{familyName}, 'DWH');
    is($person->get_field('name')->{givenName}, 'API');
    is($person->get_field('thumbnailUrl'), 'http://www.orkut.com/img/i_nophoto64.gif');
    my $result3 = $resultset->get_result('buz');
    ok(!$result3);
    my $result4 = $resultset->get_result('invalid');
    ok($result4->is_error);
    is($result4->code, 400);
    like($result4->message, qr/Invalid ID invalid/);
}

sub simple_api {
    my $person = $client->get_person('@me');
    is($person->get_field('id'), '03067092798963641994');
    ok($person->get_field('isViewer'));
    is($person->get_field('name')->{familyName}, 'DWH');
    is($person->get_field('name')->{givenName}, 'API');
    is($person->get_field('thumbnailUrl'), 'http://www.orkut.com/img/i_nophoto64.gif');

    my $invalid = $client->get_person('invalid');
    ok(!$invalid, $client->errstr);

    my $collection = $client->get_friends('@me');
    is($collection->count, 6);
    is($collection->total_results, 6);
    my $items = $collection->items;
    my $person0 = $items->[0];
    is($person0->get_field('id'), '13314698784882897227');
    ok(!$person0->get_field('isViewer'));
    is($person0->get_field('name')->{familyName}, 'Roomann-Kurrik');
    is($person0->get_field('name')->{givenName}, 'Arne');
    is($person0->get_field('thumbnailUrl'), 'http://img2.orkut.com/images/small/1195663673/115231346.jpg');
}
