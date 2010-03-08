package Net::OpenSocial::Client;

use Any::Moose;
use Any::Moose 'X::AttributeHelpers';
use Net::OpenSocial::Client::Protocol::Builder;

use Net::OpenSocial::Client::Request::FetchPeople;
use Net::OpenSocial::Client::Request::FetchPerson;
use Net::OpenSocial::Client::Request::FetchFriends;
use Net::OpenSocial::Client::Request::FetchPersonAppData;
use Net::OpenSocial::Client::Request::FetchFriendsAppData;

our $VERSION                  = '0.01_05';
our $DEFAULT_PROTOCOL_VERSION = '0.8.1';

with 'Net::OpenSocial::Client::ErrorHandler';

has 'protocol' => (
    is       => 'ro',
    isa      => 'Net::OpenSocial::Client::Protocol',
    required => 1,
);

has 'container' => (
    is       => 'ro',
    isa      => 'Net::OpenSocial::Client::Container',
    required => 1,
);

has '_requests' => (
    is        => 'ro',
    isa       => 'ArrayRef',
    default   => sub { [] },
    metaclass => 'Collection::Array',
    provides  => { clear => 'clear_requests', },
);

=head1 NAME

Net::OpenSocial::Client - OpenSocial REST/RPC Client

=head1 SYNOPSIS


    use Net::OpenSocial::Client;
    use Net::OpenSocial::Client::Container::OrkutSandbox;
    use Net::OpenSocial::Client::Type::Protocol qw(REST RPC);
    use Data::Dump qw(dump);

    my $client = Net::OpenSocial::Client->new(
        container       => Net::OpenSocial::Client::Container::OrkutSandbox->new, 
        consumer_key    => q{orkut.com:623061448914},
        consumer_secret => q{uynAeXiWTisflWX99KU1D2q5},
        requestor       => q{03067092798963641994},
        protocol_type   => RPC,
    );

    my $friends = $client->get_friends('@me')
        or die $client->errstr;
    for my $person ( @{ $friends->items } ) {
        say $person->get_field('id');
        ...

        say dump($person->fields);
    }

=head1 DESCRIPTION

OpenSocial provides API endpoints which called 'RESTful API' and 'RPC'.
This module allows you to handle it easily.
This provides you a same interface for both REST-API and RPC, so you
don't need to mind about the big differences between them.

=head1 SIMPLE USAGE

If you don't need to handle multiple requests at once for more effective performance (batch request),
this module provides you some simple methods that can handle resources easily.

    my $client = Net::OpenSocial::Client->new(...);

    my $user_id = '@me';
    my $person = $client->get_person( $user_id )
        or die $client->errstr;

    say $person->get_field('id');

    my $friends = $client->get_friends( $user_id )
        or die $client->errstr;

    foreach my $friend ( @{ $friends->items } ) {
        say $friend->get_field('id');
    }


For more details, look at each methods' document.

=over 4

=item get_people
=item get_person
=item get_friends
=item get_person_appdata
=item get_friends_appdata

=back

=head1 RAW APIs AND BATCH REQUEST

=head2 BUILD REQUEST

You can build a request object by yourself or choose from preset.
See L<Net::OpenSocial::Client::Request>.

    my $request = Net::OpenSocial::Client::Request->new(
        service   => PEOPLE,
        operation => GET,
        user_id   => '@me',
        group_id  => '@friends',
        params    => {
            itemsPerPage => 10,
            startIndex   => 10,
        },
    );

or

    my $request = Net::OpenSocial::Client::Request::FetchFriends->new( '@me',
        { itemsPerPage => 10, startIndex => 10 } );

=head2 EXECUTE REQUEST

You should add request to client with request-id.

    $client->add_request( req1 => $request1 );
    $client->add_request( req2 => $request2 );

Only execute 'add_request', you can't obtain a result corresponding to the requests.
To get them, you have to call 'send'.

    my $result_set = $client->send()

Internally, it works apropriately according to the protocol type you choose.
If RPC is selected, multiple requests are send as one single http-request.
Or with REST, it send multiple http-request for each opensocial-request.
And it returns L<Net::OpenSocial::Client::ResultSet> object.

=head2 PICK UP RESULT

Pick up L<Net::OpenSocial::Client::Result> object with
request-id you passed when invoking 'add_request'.

    my $result1 = $result_set->get_result('req1');
    my $result2 = $result_set->get_result('req2');

=head2 HANDLE DATA

    if ( $result1->is_error ) {
        die sprintf q{%d: %s.},
            $result->code, $result->message;
    } else {
        my $data = $result1->data;
        ...
    }

the data may be L<Net::OpenSocial::Client::Collection> or
L<Net::OpenSocial::Client::Resource> subclass's object.
such like L<Net::OpenSocial::Client::Resource::Person>
,L<Net::OpenSocial::Client::Resource::Activity>
,L<Net::OpenSocial::Client::Resource::AppData>
, or L<Net::OpenSocial::Client::Resource::Group>.

=head1 METHODS

=head2 new

    use Net::OpenSocial::Client::Type::Auth qw(OAUTH ST);
    use Net::OpenSocial::Client::Type::Format qw(JSON XML);
    use Net::OpenSocial::Client::Type::Protocol qw(REST RPC);

    my $client = Net::OpenSocial::Client->new(
        container     => $container,
        auty_type     => OAUTH,
        format_type   => JSON,
        protocol_type => REST,
    );

=head3 container

First, you have to prepare L<Net::OpenSocial::Client::Container> object.
You can build it with container-information you want to access as of now,
or choose from preset.
There exists container objects which support major provider.

L<Net::OpenSocial::Client::Container::Orkut>
L<Net::OpenSocial::Client::Container::MySpace>
L<Net::OpenSocial::Client::Container::Google>
and etc.


    my $container = Net::OpenSocial::Client::Container->new(...);

or

    my $container = Net::OpenSocial::Client::Container::MySpace->new;


=head3 auth_type

Authorization type.
You can choose from OAUTH and ST.
OAUTH means 2-legged or 3-legged OAuth.
When you choose OAUTH type, you have to pass both 'consumer_key' and 'consumer_secret'
parameter which you got on provider beforehand.

    my $client = Net::OpenSocial::Client->new(
        auth_type       => OAUTH,  # you can omit this. OAUTH is set by default.
        consumer_key    => q{foobarbuz},
        consumer_secret => q{foobarbuz},
        ...
    );

And if you want to use 3-legged OAuth, you need to pass authorized access-token.
You should already have completed OAuth authorization process.
See L<OAuth::Lite::Consumer>.

    my $access_token = OAuth::Lite::Token->new( token => q{aaa}, secret => {bbb} );

    my $client = Net::OpenSocial::Client->new(
        auth_type       => OAUTH,  # you can omit this. OAUTH is set by default.
        consumer_key    => q{foobarbuz},
        consumer_secret => q{foobarbuz},
        token           => $access_token,
        ...
    );

Or in case you try 2-legged OAuth.
pass user-id of xoauth_request_id as 'requestor' parameter.

    my $client = Net::OpenSocial::Client->new(
        auth_type       => OAUTH,  # you can omit this. OAUTH is set by default.
        consumer_key    => q{foobarbuz},
        consumer_secret => q{foobarbuz},
        requestor       => q{myid},
        ...
    );

ST means security-token.
You have pass to security-token as 'st' parameter.

    my $client = Net::OpenSocial::Client->new(
        auth_type => ST,
        st        => q{foobarbuz},
        ...
    );

=head3 format_type

Now it only supports JSON format, so, it sets JSON by default.

=head3 protocol_type

REST or RPC.
REST is set by default.
Make sure that the container which you want to access supports
the protocol.

If container supports RPC, and you choose it, you can execute
batch request.

=head2 BUILDARGS

See L<Moose>, L<Mouse>.
You don't need to call this method directly.

=cut

sub BUILDARGS {
    my ( $self, %args ) = @_;
    my $params = {};
    $params->{container} = delete $args{container};
    unless ( exists $args{protocol} ) {
        my $builder  = Net::OpenSocial::Client::Protocol::Builder->new(%args);
        my $protocol = $builder->build_protocol()
            or die $builder->errstr;
        $params->{protocol} = $protocol;
    }
    return $params;
}

=head2 add_request( $request )

Pass L<Net::OpenSocial::Client::Request> or its subclass's object.
At this time, noghing happens. When you execute 'send' method,
You will get the result of this request.

You should make ID string for the request arbitrarily,
and set it with the request.
Remember this ID to pick up a result you want from result-set
that you get after executing 'send' method.

    $client->add_request( $request_id => $request );

=cut

sub add_request {
    my ( $self, $id, $req ) = @_;
    $req->id($id);
    push( @{ $self->_requests }, $req );
}

=head2 send()

This method send all requests that you added by 'add_request' before you call this.
If it's done successfuly, it returns a L<Net::OpenSocial::Client::ResultSet> object.

To obtain a result you want, you need to invoke 'get_result' method of result-set object
with request-id you set when you do 'add_request'.
Then it returns a L<Net::OpenSocial::Client::Result> object.

    my $result_set = $client->send()
        or die $client->errstr;
    my $result = $result_set->get_result($request_id);

=cut

sub send {
    my $self     = shift;
    my @requests = @{ $self->_requests };
    $self->clear_requests();
    my $result_set = $self->protocol->execute( $self->container, \@requests )
        or return $self->ERROR( $self->protocol->errstr );
    return $result_set;
}

=head2 get_people( $user_id, $group_id, $option )

    my $people = $client->get_people( '@me', '@friends', { itemsPerPage => 10 } );
    say $people->count;
    for my $person ( @{ $people->items } ) {
        say $person->get_field('id');
    }

=cut

sub get_people {
    my ( $self, $user_id, $group_id, $params ) = @_;
    $self->clear_requests();
    my $req_id = 'get_people';
    my $req    = Net::OpenSocial::Client::Request::FetchPeople->new( $user_id,
        $group_id, $params );
    $self->add_request( $req_id => $req );
    my $result_set = $self->send() or return;
    my $result = $result_set->get_result($req_id);
    return $self->ERROR( $result->message ) if $result->is_error;
    return $result->data;
}

=head2 get_person( $user_id )

    my $person = $client->get_person('@me');
    say $person->get_field('id');

=cut

sub get_person {
    my ( $self, $user_id ) = @_;
    $self->clear_requests();
    my $req_id = 'get_person';
    my $req    = Net::OpenSocial::Client::Request::FetchPerson->new($user_id);
    $self->add_request( $req_id => $req );
    my $result_set = $self->send() or return;
    my $result = $result_set->get_result($req_id);
    return $self->ERROR( $result->message ) if $result->is_error;
    return $result->data->first;
}

=head2 get_friends( $user_id, $option )

    my $people = $client->get_people( '@me', { itemsPerPage => 10 } );
    say $people->count;
    for my $person ( @{ $people->items } ) {
        say $person->get_field('id');
    }

=cut

sub get_friends {
    my ( $self, $user_id, $params ) = @_;
    $self->clear_requests();
    my $req_id = 'get_friends';
    my $req = Net::OpenSocial::Client::Request::FetchFriends->new( $user_id,
        $params );
    $self->add_request( $req_id => $req );
    my $result_set = $self->send() or return;
    my $result = $result_set->get_result($req_id);
    return $self->ERROR( $result->message ) if $result->is_error;
    return $result->data;
}

=head2 get_person_appdata( $user_id, $option )

returns L<Net::OpenSocial::Client::Resource::AppData>.

    my $appdata = $client->get_person_appdata('@me')
        or die $client->errstr;
    say $appdata->get_data($user_id, $key);

=cut

sub get_person_appdata {
    my ( $self, $user_id, $params ) = @_;
    $self->clear_requests();
    my $req_id = 'get_person_appdata';
    my $req
        = Net::OpenSocial::Client::Request::FetchPersonAppData->new( $user_id, $params );
    $self->add_request( $req_id => $req );
    my $result_set = $self->send() or return;
    my $result = $result_set->get_result($req_id);
    return $self->ERROR( $result->message ) if $result->is_error;
    return $result->data->first;
}

=head2 get_friends_appdata( $user_id, $option )

    my $collection = $client->get_friends_appdata('@me')
        or die $client->errstr;
    for my $appdata ( @{ $collection->items } ) {
        ...
    }

=cut

sub get_friends_appdata {
    my ( $self, $user_id, $params ) = @_;
    $self->clear_requests();
    my $req_id = 'get_friens_appdata';
    my $req    = Net::OpenSocial::Client::Request::FetchFriendsAppData->new(
        $user_id, $params );
    $self->add_request( $req_id => $req );
    my $result_set = $self->send() or return;
    my $result = $result_set->get_result($req_id);
    return $self->ERROR( $result->message ) if $result->is_error;
    return $result->data;
}

=head1 DEVELOPMENT

I'm woking on github.
http://github.com/lyokato/p5-net-opensocial-client/tree/master

=head1 SEE ALSO

L<http://code.google.com/apis/opensocial/docs/>,
L<http://www.opensocial.org/Technical-Resources/opensocial-spec-v081/restful-protocol>,
L<http://www.opensocial.org/Technical-Resources/opensocial-spec-v081/rpc-protocol>,
L<http://code.google.com/apis/friendconnect/opensocial_rest_rpc.html>
L<http://blog.opensocial.org/2008/12/opensocial-now-friends-with-php-java.html>

=head1 AUTHOR

Lyo Kato, E<lt>lyo.kato@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Lyo Kato

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

