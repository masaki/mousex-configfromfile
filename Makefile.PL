use inc::Module::Install;
name 'MouseX-ConfigFromFile';
all_from 'lib/MouseX/ConfigFromFile.pm';

requires 'Mouse' => '0.19';
requires 'Mouse::Role';
requires 'MouseX::Types::Path::Class' => '0.05';

tests 't/*.t';
test_requires 'Any::Moose' => '0.05';
test_requires 'Test::More';
test_requires 'Test::UseAllModules';
author_tests 'xt';
use_test_base;

auto_include_deps;
WriteAll;
