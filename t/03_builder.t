use Test::More tests => 5;
use Path::Class;

do {
    package MyApp;
    use Mouse;
    use File::Spec;

    with 'MouseX::ConfigFromFile';

    has 'name' => (is => 'rw', isa => 'Str');
    has 'host' => (is => 'rw', isa => 'Str');
    has 'port' => (is => 'rw', isa => 'Int');

    has '+configfile' => (builder => '_build_configfile');

    sub _build_configfile { '/path/to/myapp.conf' }

    sub get_config_from_file {
        my (undef, $file) = @_;
        return +{ host => 'localhost', port => 3000 };
    }
};

my $app = MyApp->new_with_config(name => 'MyApp');

is $app->configfile => file('/path/to/myapp.conf'), 'configfile ok';
isa_ok $app->configfile => 'Path::Class::File';
is $app->host => 'localhost', 'get_config_from_file ok';
is $app->port => 3000, 'get_config_from_file ok';
is $app->name => 'MyApp', 'extra params ok';
