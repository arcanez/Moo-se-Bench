#!/usr/bin/env perl

package Moo::Reader;
use Moo;
has value => ( is=>'ro' );

package Moose::Reader;
use Moose;
has value => ( is=>'ro' );
__PACKAGE__->meta->make_immutable;

package main;

use strict;
use warnings FATAL => 'all';

use Benchmark qw(:all) ;

my $moo = Moo::Reader->new( value=>3 );
my $moose = Moose::Reader->new( value=>3 );

cmpthese(2_000_000, {
    Moo   => sub{ $moo->value() },
    Moose => sub{ $moose->value() },
});
