#!/usr/bin/perl

use strict;
use warnings;

while (<>) {
	if (/Best score = (.*)/) {
		my $energy = $1 == 1 ? "error" : ((1/$1) + 1);
		print "$ARGV	$energy\n";
	}
}
