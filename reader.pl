#!/usr/bin/env perl
use strict;
use warnings FATAL => 'all';

use Benchmark qw(:all) ;

{
    package Moo::Reader;
    use Moo;
    has value => ( is=>'ro' );
}

{
    package Moose::Reader;
    use Moose;
    has value => ( is=>'ro' );
}

my $moo = Moo::Reader->new( value=>3 );
my $moose = Moose::Reader->new( value=>3 );

cmpthese(2_000_000, {
    Moo   => sub{ $moo->value() },
    Moose => sub{ $moose->value() },
});
