#!/usr/bin/env perl

package Moo::NoValidation;
use Moo;
has value => ( is=>'ro', writer=>'set_value' );

package Moose::NoValidation;
use Moose;
has value => ( is=>'ro', writer=>'set_value' );
__PACKAGE__->meta->make_immutable;

package Moose::CoreValidation;
use Moose;
has value => ( is=>'ro', isa=>'Str', writer=>'set_value' );
__PACKAGE__->meta->make_immutable;

package Moo::TypeTiny;
use Types::Standard -types;
use Moo;
has value => ( is=>'ro', isa=>Str, writer=>'set_value' );

package Moose::TypeTiny;
use Types::Standard -types;
use Moose;
has value => ( is=>'ro', isa=>Str, writer=>'set_value' );
__PACKAGE__->meta->make_immutable;

package Moo::MooseLike;
use MooX::Types::MooseLike::Base qw(:all);
use Moo;
has value => ( is=>'ro', isa=>Str, writer=>'set_value' );

package Moo::MooXTypeTiny;
use Moo;
use MooX::TypeTiny;
use Types::Standard -types;
has value => ( is=>'ro', isa=>Str, writer=>'set_value' );

package main;

use strict;
use warnings FATAL => 'all';

use Benchmark qw(:all) ;

my $moo_no_validation = Moo::NoValidation->new();
my $moose_no_validation = Moose::NoValidation->new();
my $moose_core_validation = Moose::CoreValidation->new();
my $moo_type_tiny = Moo::TypeTiny->new();
my $moose_type_tiny = Moose::TypeTiny->new();
my $moo_moose_like = Moo::MooseLike->new();
my $moo_moox_type_tiny = Moo::MooXTypeTiny->new();

cmpthese(2_000_000, {
    Moo_NoValidation     => sub{ $moo_no_validation->set_value('i_am_s_string') },
    Moose_NoValidation   => sub{ $moose_no_validation->set_value('i_am_s_string') },
    Moose_CoreValidation => sub{ $moose_core_validation->set_value('i_am_s_string') },
    Moo_TypeTiny         => sub{ $moo_type_tiny->set_value('i_am_s_string') },
    Moose_TypeTiny       => sub{ $moose_type_tiny->set_value('i_am_s_string') },
    Moo_MooseLike        => sub{ $moo_moose_like->set_value('i_am_s_string') },
    Moo_MooX_TypeTiny    => sub{ $moo_moox_type_tiny->set_value('i_am_s_string') },
});
