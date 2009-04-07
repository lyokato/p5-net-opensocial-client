package Net::OpenSocial::Client::Request::UpdatePersonAppData;

use Any::Moose;
extends 'Net::OpenSocial::Client::Request';

use Net::OpenSocial::Client::Type::Service qw(APPDATA);
use Net::OpenSocial::Client::Type::Operation qw(UPDATE);

sub BUILDARGS {
    my ( $self, $user_id, $resource, $params ) = @_;
    $params ||= {};
    $params->{appId} ||= '@app';
    my $args = {
        service   => APPDATA,
        operation => UPDATE,
        user_id   => $user_id || '@me',
        group_id  => '@self',
        params    => $params,
    };
    $args->{resource} = $resource if $resource;
    return $args;
}

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

=head1 NAME

Net::OpenSocial::Client::Request::UpdatePersonAppData - update AppData for person

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHODS

=head2 BUILDARGS

See L<Moose> or L<Mouse>

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

