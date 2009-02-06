use inc::Module::Install;
name 'MouseX-ConfigFromFile';
all_from 'lib/MouseX/ConfigFromFile.pm';

requires 'Mouse' => '0.15';
requires 'MouseX::Types::Path::Class' => '0.03';

tests 't/*.t';
test_requires 'Test::More';
test_requires 'ok';
author_tests 'xt';
use_test_base;

auto_include_deps;
WriteAll;
