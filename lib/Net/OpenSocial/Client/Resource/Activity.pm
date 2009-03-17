package Net::OpenSocial::Client::Activity;

use Any::Moose;
extends 'Net::OpenSocial::Client::Resource';


has 'app_id' => ();
has 'body' => ();
has 'body_id' => ();
has 'external_id' => ();
has 'id' => ();
has 'media_items' => ();
has 'posted_time' => ();
has 'priority' => ();
has 'template_params' => ();
has 'title' => ();
has 'title_id' => ();
has 'url' => ();
has 'user_id' => ();

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;
