use strict;
use Test::More tests => 18;

#use Moose;
use Net::OpenSocial::Client;
use Net::OpenSocial::Client::Type::Protocol qw(RPC REST);
use Net::OpenSocial::Client::Type::Format qw(JSON XML);
use Net::OpenSocial::Client::Request::FetchPersonAppData;
use Net::OpenSocial::Client::Request::FetchFriendsAppData;
use Net::OpenSocial::Client::Container::OrkutSandbox;
use Net::OpenSocial::Client::Agent::Dump;
use OAuth::Lite::Consumer;

my $user_id = q{03067092798963641994};

my $client = Net::OpenSocial::Client->new(
    container       => Net::OpenSocial::Client::Container::OrkutSandbox->new,
    consumer_key    => q{orkut.com:623061448914},
    consumer_secret => q{uynAeXiWTisflWX99KU1D2q5},
    requestor       => $user_id,
    #protocol_type  => RPC,
    #auth_type      => ST,
);

&raw_api();
&simple_api();

sub raw_api {
    my $req
        = Net::OpenSocial::Client::Request::FetchFriendsAppData->new( '@me' );
    $client->add_request( foo => $req );
    my $req2
        = Net::OpenSocial::Client::Request::FetchPersonAppData->new( '@me' );
    $client->add_request( bar => $req2 );

    my $req3
        = Net::OpenSocial::Client::Request::FetchPersonAppData->new( 'invalid' );
    $client->add_request( invalid => $req3 );
        
    my $resultset = $client->send();
    ok($resultset);
    my $result1 = $resultset->get_result('foo');
    ok($result1);
    my $coll = $result1->data;
    is($coll->count, 0);
    my $result2 = $resultset->get_result('bar');
    ok($result2);
    my $appdata = $result2->data->first;
    ok($appdata);
    is($appdata->get_data($user_id, 'a'), 'a1');
    is($appdata->get_data($user_id, 'b'), 'b1');
    is($appdata->get_data($user_id, 'date'), 'Sunday 8th of February 2009 04:26:30 PM');
    my $result3 = $resultset->get_result('buz');
    ok(!$result3);
    my $result4 = $resultset->get_result('invalid');
    ok($result4->is_error);
    is($result4->code, 400);
    like($result4->message, qr/Invalid ID invalid/);
}

sub simple_api {
    my $appdata = $client->get_person_appdata('@me');
    ok($appdata);
    is($appdata->get_data($user_id, 'a'), 'a1');
    is($appdata->get_data($user_id, 'b'), 'b1');
    is($appdata->get_data($user_id, 'date'), 'Sunday 8th of February 2009 04:26:30 PM');

    my $invalid = $client->get_person_appdata('invalid');
    ok(!$invalid);

    my $friends_app = $client->get_friends_appdata('@me');
    is($friends_app->count, 0);
}
