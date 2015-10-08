#!/usr/bin/env perl

package Moo::None;
use Moo;
has value => (is=>'ro', clearer=>1);

package Moose::None;
use Moose;
has value => (is=>'ro', clearer=>'clear_value');
__PACKAGE__->meta->make_immutable;

package Moo::Default;
use Moo;
has value => (is=>'ro', clearer=>1, default=>2);

package Moose::Default;
use Moose;
has value => (is=>'ro', clearer=>'clear_value', default=>2);
__PACKAGE__->meta->make_immutable;

package Moo::Lazy;
use Moo;
has value => (is=>'lazy', clearer=>1);
sub _build_value { 2 }

package Moose::Lazy;
use Moose;
has value => (is=>'ro', clearer=>'clear_value', lazy=>1, builder=>'_build_value');
sub _build_value { 2 }
__PACKAGE__->meta->make_immutable;

package main;

use strict;
use warnings FATAL => 'all';

use Benchmark qw(:all) ;

my $existing_moo_none      = Moo::None->new();
my $existing_moose_none    = Moo::None->new();
my $existing_moo_default   = Moo::Default->new();
my $existing_moose_default = Moo::Default->new();
my $existing_moo_lazy      = Moo::Lazy->new();
my $existing_moose_lazy    = Moo::Lazy->new();

cmpthese(500_000, {
    New_Moo_None      => sub{ Moo::None->new->value() },
    New_Moose_None    => sub{ Moose::None->new->value() },
    New_Moo_Default   => sub{ Moo::Default->new->value() },
    New_Moose_Default => sub{ Moose::Default->new->value() },
    New_Moo_Lazy      => sub{ Moo::Lazy->new->value() },
    New_Moose_Lazy    => sub{ Moose::Lazy->new->value() },
});

cmpthese(10_000_000, {
    Existing_Moo_None      => sub{ $existing_moo_none->value() },
    Existing_Moose_None    => sub{ $existing_moose_none->value() },
    Existing_Moo_Default   => sub{ $existing_moo_default->value() },
    Existing_Moose_Default => sub{ $existing_moose_default->value() },
    Existing_Moo_Lazy      => sub{ $existing_moo_lazy->value() },
    Existing_Moose_Lazy    => sub{ $existing_moose_lazy->value() },
});

cmpthese(5_000_000, {
    Clear_Moo_None      => sub{ $existing_moo_none->clear_value(); $existing_moo_none->value() },
    Clear_Moose_None    => sub{ $existing_moose_none->clear_value(); $existing_moose_none->value() },
    Clear_Moo_Default   => sub{ $existing_moo_default->clear_value(); $existing_moo_default->value() },
    Clear_Moose_Default => sub{ $existing_moose_default->clear_value(); $existing_moose_default->value() },
    Clear_Moo_Lazy      => sub{ $existing_moo_lazy->clear_value(); $existing_moo_lazy->value() },
    Clear_Moose_Lazy    => sub{ $existing_moose_lazy->clear_value(); $existing_moose_lazy->value() },
});
