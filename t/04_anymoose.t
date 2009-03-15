use Test::More tests => 5;

BEGIN { $ENV{ANY_MOOSE} = 'Mouse' }

do {
    package MyApp;
    use Any::Moose;

    with any_moose('X::ConfigFromFile');

    has 'name' => (is => 'rw', isa => 'Str');
    has 'host' => (is => 'rw', isa => 'Str');
    has 'port' => (is => 'rw', isa => 'Int');

    sub get_config_from_file {
        my (undef, $file) = @_;
        return +{ host => 'localhost', port => 3000 };
    }
};

my $app = MyApp->new_with_config(
    name       => 'MyApp',
    configfile => '/path/to/myapp.conf',
);

isa_ok $app->meta => 'Mouse::Meta::Class';

is $app->configfile => '/path/to/myapp.conf', 'configfile ok';
is $app->host => 'localhost', 'get_config_from_file ok';
is $app->port => 3000, 'get_config_from_file ok';
is $app->name => 'MyApp', 'extra params ok';
