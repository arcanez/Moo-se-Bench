#!/usr/bin/env perl
use strict;
use warnings FATAL => 'all';

use Benchmark qw(:all) ;

cmpthese(100, {
    Perl  => sub { system('perl', '-e', '') },
    Moo   => sub { system('perl', '-e', 'use Moo') },
    Moose => sub { system('perl', '-e', 'use Moose') },
});

cmpthese(100, {
    Moo   => sub { system('perl', '-e', 'package Foo; use Moo; has foo => ( is=>"ro" )') },
    Moose => sub { system('perl', '-e', 'package Foo; use Moose; has foo => ( is=>"ro" )') },
});
