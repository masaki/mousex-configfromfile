use Test::More tests => 10;
use Path::Class;

do {
    package MyApp::DefaultStr;
    use Mouse;

    with 'MouseX::ConfigFromFile';

    has 'name' => (is => 'rw', isa => 'Str');
    has 'host' => (is => 'rw', isa => 'Str');
    has 'port' => (is => 'rw', isa => 'Int');

    has '+configfile' => (default => '/path/to/myapp.conf');

    sub get_config_from_file {
        my (undef, $file) = @_;
        return +{ host => 'localhost', port => 3000 };
    }

    package MyApp::DefaultSub;
    use Mouse;

    with 'MouseX::ConfigFromFile';

    has 'name' => (is => 'rw', isa => 'Str');
    has 'host' => (is => 'rw', isa => 'Str');
    has 'port' => (is => 'rw', isa => 'Int');

    has '+configfile' => (default => sub { '/path/to/myapp.conf' });

    sub get_config_from_file {
        my (undef, $file) = @_;
        return +{ host => 'localhost', port => 3000 };
    }
};

for my $class (qw/MyApp::DefaultStr MyApp::DefaultSub/) {
    my $app = $class->new_with_config(name => 'MyApp');

    is $app->configfile => file('/path/to/myapp.conf'), 'default configfile ok';
    isa_ok $app->configfile => 'Path::Class::File';
    is $app->host => 'localhost', 'get_config_from_file ok';
    is $app->port => 3000, 'get_config_from_file ok';
    is $app->name => 'MyApp', 'extra params ok';
}
