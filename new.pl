#!/usr/bin/env perl
use strict;
use warnings FATAL => 'all';

use Benchmark qw(:all) ;

{ package Moo::Basic; use Moo }
{ package Moose::Basic; use Moose }

{ package Moo::Default; use Moo; has value => (is=>'ro', default=>2) }
{ package Moose::Default; use Moose; has value => (is=>'ro', default=>2) }

{ package Moo::NoInit; use Moo; has value => (is=>'ro', init_arg=>undef) }
{ package Moose::NoInit; use Moose; has value => (is=>'ro', init_arg=>undef) }

cmpthese(500_000, {
    Moo_Basic     => sub{ Moo::Basic->new() },
    Moose_Basic   => sub{ Moose::Basic->new() },
    Moo_Default   => sub{ Moo::Default->new() },
    Moose_Default => sub{ Moose::Default->new() },
    Moo_NoInit    => sub{ Moo::NoInit->new() },
    Moose_NoInit  => sub{ Moose::NoInit->new() },
});
