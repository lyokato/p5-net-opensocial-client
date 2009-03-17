package Net::OpenSocial::Client::Group;

use Any::Moose;
extends 'Net::OpenSocial::Client::Resource';

has 'id'    => ();
has 'title' => ();

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;


