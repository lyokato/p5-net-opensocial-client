use Test::Dependencies
    exclude => [qw(Test::Dependencies Test::Base Test::Perl::Critic Net::OpenSocial::Client)],
    style   => 'light';
ok_dependencies();
