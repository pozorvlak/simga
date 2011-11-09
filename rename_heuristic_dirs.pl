#!/usr/bin/perl

use strict;
use warnings;
use Sim::Flags;

if (-d "backup") {
	chdir "backup";
}

for my $dir (glob("*")) {
	my @genes = split /:/, $dir;
	for my $i (0 .. $#genes) {
		if ($genes[$i] == 1) {
			my $heuristic = $Sim::Flags::flag_names[$i];
			$heuristic =~ s/^-//;
			print "Moving $dir to $heuristic\n";
			rename $dir, $heuristic;
		}
	}
}

