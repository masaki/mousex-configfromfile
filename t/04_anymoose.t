use Test::More tests => 6;
use Path::Class;

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

my $file = file('/path/to/myapp.conf');
my $app = MyApp->new_with_config(
    name       => 'MyApp',
    configfile => "$file",
);

isa_ok $app->meta => 'Mouse::Meta::Class';

is $app->configfile => $file, 'configfile ok';
isa_ok $app->configfile => 'Path::Class::File';
is $app->host => 'localhost', 'get_config_from_file ok';
is $app->port => 3000, 'get_config_from_file ok';
is $app->name => 'MyApp', 'extra params ok';
