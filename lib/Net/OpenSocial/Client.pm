package Net::OpenSocial::Client;

use Any::Moose;
use Any::Moose 'X::AttributeHelpers';
use Net::OpenSocial::Client::Protocol::Builder;

use Net::OpenSocial::Client::Request::GetPeople;
use Net::OpenSocial::Client::Request::GetPerson;
use Net::OpenSocial::Client::Request::GetFriends;
use Net::OpenSocial::Client::Request::GetPersonAppData;
use Net::OpenSocial::Client::Request::GetFriendsAppData;

our @DEFAULT_PROTOCOL_VERSION = q{0.8.1};

with 'Net::OpenSocial::Client::ErrorHandler';

has 'protocol' => (
    is  => 'ro',
    isa => 'Net::OpenSocial::Client::Protocol',
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

sub add_request {
    my ( $self, $id, $req ) = @_;
    $req->id($id);
    push( @{ $self->_requests }, $req );
}

sub send {
    my $self     = shift;
    my @requests = @{ $self->_requests };
    $self->clear_requests();
    my $result_set = $self->protocol->execute( $self->container, \@requests )
        or return $self->ERROR( $self->protocol->errstr );
    return $result_set;
}

sub get_people {
    my ( $self, $user_id, $group_id, $params ) = @_;
    $self->clear_requests();
    my $req_id = 'get_people';
    my $req    = Net::OpenSocial::Client::Request::GetPeople->new( $user_id,
        $group_id, $params );
    $self->add_request( $req_id => $req );
    my $result_set = $self->send() or return;
    my $result = $result_set->get_result($req_id);
    if ( $result->is_error ) {
        return $self->ERROR( $result->message );
    }
    return $result->data;
}

sub get_person {
    my ( $self, $user_id ) = @_;
    $self->clear_requests();
    my $req_id = 'get_person';
    my $req    = Net::OpenSocial::Client::Request::GetPerson->new($user_id);
    $self->add_request( $req_id => $req );
    my $result_set = $self->send() or return;
    my $result = $result_set->get_result($req_id);
    if ( $result->is_error ) {
        return $self->ERROR( $result->message );
    }
    return $result->data;
}

sub get_friends {
    my ( $self, $user_id, $params ) = @_;
    $self->clear_requests();
    my $req_id = 'get_friends';
    my $req    = Net::OpenSocial::Client::Request::GetFriends->new( $user_id,
        $params );
    $self->add_request( $req_id => $req );
    my $result_set = $self->send() or return;
    my $result = $result_set->get_result($req_id);
    if ( $result->is_error ) {
        return $self->ERROR( $result->message );
    }
    return $result->data;
}

sub get_person_appdata {
    my ( $self, $user_id, $params ) = @_;
    $self->clear_requests();
    my $req_id = 'get_person_appdata';
    my $req
        = Net::OpenSocial::Client::Request::GetPersonAppData->new( $user_id,
        '@app', $params );
    $self->add_request( $req_id => $req );
    my $result_set = $self->send() or return;
    my $result = $result_set->get_result($req_id);
    if ( $result->is_error ) {
        return $self->ERROR( $result->message );
    }
    return $result->data;
}

sub get_friends_appdata {
    my ( $self, $user_id, $params ) = @_;
    $self->clear_requests();
    my $req_id = '';
    my $req
        = Net::OpenSocial::Client::Request::GetFriendsAppData->new( $user_id,
        '@app', $params );
    my $result_set = $self->send() or return;
    my $result = $result_set->get_result($req_id);
    if ( $result->is_error ) {
        return $self->ERROR( $result->message );
    }
    return $result->data;
}

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

=head1 SYNOPSIS


    my $container = Net::OpenSocial::Client::Container->new(
        endpoint => q{},
        rest     => q{},
        rpc      => q{},
    );

    my $client = Net::OpenSocial::Client->new(
        container       => $container,
        auth_type       => HMAC,
        consumer_key    => '',
        consumer_secret => '',
        protocol_type   => RPC,
    );

    my $req1 = Net::OpenSocial::Client::Request->new(
        service   => PEOPLE,
        operation => GET,
        user_id   => '@me',
        group_id  => '@self',
    );

    $client->add_request( req_id_1 => $req1 );
    $client->add_request( req_id_2 => $req2 );

    my $result_set = $client->send();
    my $res1 = $result_set->get_result('req_id_1');

    if ( $res1->is_error ) {
        $res1->code;
        $res1->message;
    } else {
        my $collection = $res1->data;
        for my $person ( @{ $collection->items } ) {
            say $person->name;
        }
    }

=cut

