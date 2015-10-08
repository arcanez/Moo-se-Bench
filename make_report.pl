#!/usr/bin/env perl
use strict;
use warnings FATAL => 'all';

use Config;

my $version = `perl -v`;
if ($version =~ m{\b(v[\d.]+)}) {
    $version = $1;
}
else {
    die "Unable to find version";
}

my $label = join('-',
    $version,
    time(),
    $Config{osname},
    $Config{osvers},
    $Config{archname},
);

my $file = "reports/$label.txt";

foreach my $script (qw(
    use.pl
    new.pl
    writer.pl
    reader.pl
    default_vs_lazy.pl
)) {
    print "$script...\n";
    system("perl $script >> $file");
}

print "DONE: $file\n";
