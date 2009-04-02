package Net::OpenSocial::Client::Request::CreateAppData;

use Any::Moose;
extends 'Net::OpenSocial::Client::Request';

use Net::OpenSocial::Client::Type::Service qw(APPDATA);
use Net::OpenSocial::Client::Type::Operation qw(CREATE);

sub BUILDARGS {
    my ( $self, $user_id, $group_id, $app_id, $resource, $params ) = @_;
    $params ||= {};
    $params->{appId} = $app_id if $app_id;
    my $args = {
        service   => APPDATA,
        operation => CREATE,
        user_id   => $user_id || '@me',
        group_id  => $group_id || '@self',
        params    => $params,
    };
    $args->{resource} = $resource if $resource;
    return $args;
}

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

=head1 NAME

Net::OpenSocial::Client::Request::CreateAppData - Request to create AppData

=head1 SYNOPSIS

    my $req = Net::OpenSocial::Client::Request::CreateAppData->new();

=head1 DESCRIPTION

=head1 SEE ALSO

L<Net::OpenSocial::Client::Request>

=head1 AUTHOR

Lyo Kato, E<lt>lyo.kato@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Lyo Kato

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut

