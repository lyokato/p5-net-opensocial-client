package Net::OpenSocial::Client::Formatter::JSON;

use Any::Moose;
with 'Net::OpenSocial::Client::Formatter';

use JSON ();

has '+name' => (
    default => q{json},
);

has '+content_type' => (
    default => q{application/json},
);

sub encode {
    my ( $self, $obj ) = @_;
    my $content = JSON::encode_json($obj);
    return $content;
}

sub decode {
    my ( $self, $content ) = @_;
    my $obj = JSON::decode_json($content);
    return $obj;
}

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

=head1 NAME

Net::OpenSocial::Client::Formatter::JSON - JSON formatter

=head1 SYNOPSIS

    my $formatter = Net::OpenSocial::Client::Formatter::JSON->new;
    my $request_content = $formatter->encode( $request_obj );
    ...
    my $response_obj = $formatter->decode( $response_content );

=head1 DESCRIPTION

JSON formatter

=head1 METHODS

=head2 content_type

Mime type for the format.

=head2 name

Formatter name

=head2 encode

Encode perl object to a formatted JSON string.

=head2 decode

Decode JSON formatted string to perl object.

=head1 AUTHOR

Lyo Kato, E<lt>lyo.kato@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Lyo Kato

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut

