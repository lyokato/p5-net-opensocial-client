package Net::OpenSocial::Client;

use Any::Moose;
use Any::Moose 'X::AttributeHelpers';
use Net::OpenSocial::Client::Protocol::Builder;

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
    is      => 'ro',
    isa     => 'HashRef',
    default => sub { +{} },
    metaclass => 'Collection::Hash',
    provides => {
        clear => 'clear_requests', 
        set   => 'add_request',
    },
);

sub BUILD {
    my ( $self, $params ) = @_;

    return if $self->protocol;

    delete $params->{protocol};
    delete $params->{container};

    my $builder = Net::OpenSocial::Client::Protocol::Builder->new(%$params);
    my $protocol = $builder->build_protocol()
        or die $builder->errstr;

    $self->protocol($protocol);
}

sub get_person {
    my ( $self, $user_id, $group_id, $p_id, $option ) = @_;
    my $people = $self->get_people( $user_id, $group_id, $p_id, $option );
    return $people->first;
}

sub get_people {
    my ( $self, $user_id, $group_id, $p_id, $option ) = @_;
    $user_id  ||= '@me';
    $group_id ||= '@self';
    my $req = Net::OpenSocial::Client::Request->new(
        id        => '',
        service   => 'people',
        operation => 'get',
        params    => {
            user_id  => $user_id,
            group_id => $group_id,
        },
    );
    $self->protocol->add_request($req);
    my $responses  = $self->protocol->execute( $self->container );
    my $result     = $responses->[0];
    my $collection = Net::OpenSocial::Client::Collection->new;
    $collection->total_results( $result->{total_results} )
        if exists $result->{total_results};
    $collection->start_index( $result->{start_index} )
        if exists $result->{start_index};
    $collection->items_per_page( $result->{items_per_page} )
        if exists $result->{items_per_page};
        #$collection->add_resource($person);
    return $collection;
}

sub get_groups {
    my ( $self, $user_id, $option ) = @_;
    $user_id ||= '@me';
}

sub get_activities {
    my ( $self, $user_id, $group_id, $app_id, $option ) = @_;
    $user_id  ||= '@me';
    $group_id ||= '@self';
}

sub get_appdata {
    my ( $self, $user_id, $group_id, $app_id, $option ) = @_;
    $user_id  ||= '@me';
    $group_id ||= '@self';
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
        id        => q{hoge},
        service   => PEOPLE,
        operation => GET,
        user_id   => '@me',
        group_id  => '@self',
    );

    $client->add_request( $req1 );
    $client->add_request( $req2 );

    my $result_set = $client->send();
    my $res1 = $result_set->get_result('hoge');

    if ( $res1->is_error ) {
        $res1->code;
        $res1->message;
    } else {
        my $collection = $res1->resources;
        for my $person ( @{ $collection->items } ) {
            say $person->name;
        }
    }

=cut

