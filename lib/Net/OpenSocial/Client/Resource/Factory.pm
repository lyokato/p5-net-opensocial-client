package Net::OpenSocial::Client::Resource::Factory;

use Any::Moose;
use Net::OpenSocial::Client::Type::Service qw(PEOPLE GROUP ACTIVITY APPDATA);

use Net::OpenSocial::Client::Resource::Person;
use Net::OpenSocial::Client::Resource::Activity;
use Net::OpenSocial::Client::Resource::AppData;
use Net::OpenSocial::Client::Resource::Group;

sub gen_resource {
    my ( $class, $service, $data ) = @_;
    if ( $service eq PEOPLE ) {
        return Net::OpenSocial::Client::Resource::Person->new(
            fields => $data );
    }
    elsif ( $service eq GROUP ) {
        return Net::OpenSocial::Client::Resource::Group->new(
            fields => $data );
    }
    elsif ( $service eq ACTIVITY ) {
        return Net::OpenSocial::Client::Resource::Activity->new(
            fields => $data );
    }
    elsif ( $service eq APPDATA ) {
        return Net::OpenSocial::Client::Resource::AppData->new(
            fields => $data );
    }
}

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

