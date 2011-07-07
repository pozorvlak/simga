#!/usr/bin/perl

use strict;
use warnings;
use autodie;
use File::Find;
use 5.010;
use Cwd;
use Sim::GA qw/energy_from_log/;

my $rootdir = getcwd();

for my $chrom (<backup/*>) {
	chdir $chrom;
	my $energy = 0;
	for my $logfile (<*>) {
		$energy += energy_from_log($logfile);
	}
	open my $total, ">", "total";
	say $total $energy;
	say "$chrom\t$energy";
	chdir($rootdir);
}
