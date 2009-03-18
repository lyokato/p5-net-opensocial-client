package Net::OpenSocial::Client::Protocol::RPC;

use Any::Moose;
extends 'Net::OpenSocial::Client::Protocol';
with 'Net::OpenSocial::Client::ErrorHandler';
use Net::OpenSocial::Client::ResultSet;

override 'execute' => sub {
    my ( $self, $container, $requests ) = @_;

    return $self->ERROR(q{This container doesn't support rpc endpoint.})
        unless $container->rpc;

    my $url = sprintf( q{%s/%s}, $container->endpoint, $container->rpc );
    my $method = 'POST';

    my @obj;
    for my $request (@$requests) {
        my $obj = {};
        $obj->{method}
            = sprintf( q{%s.%s}, $request->rpc_service, $request->operation );
        $obj->{id}     = $request->id;
        $obj->{params} = $request->params;
        push( @obj, $obj );
    }
    my $content = $self->formatter->encode( @obj > 1 ? [@obj] : $obj[0] );

    my $http_req = $self->request_builder->build_request(
        method       => $method,
        url          => $url,
        content_type => $self->formatter->content_type,
        content      => $content,
    );
    my $http_res = $self->agent->request($http_req);
    unless ( $http_res->is_success ) {
        return $self->ERROR($http_res->status_line);
    }
    my $result = $self->formatter->decode( $http_res->content );
    unless ( ref $result eq 'ARRAY' ) {
        $result = [$result];
    }
    my $result_set = Net::OpenSocial::Client::ResultSet->new;
    for my $r ( $result ) {
        $result_set->set_result( $r->id, $r );
    }
    return $result;
};

no Any::Moose;
__PACKAGE__->meta->make_immutable;
1;

