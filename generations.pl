#!/usr/bin/perl

use strict;
use warnings;
use Sim::Generations;

sub usage {
	print "Usage: $0 [logfile.ga]";
}

my $population = 50;
if ($ARGC < 1) {
	usage();
}
print Sim::Generations($ARGV[0], $population);
