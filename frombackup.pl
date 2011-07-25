#!/usr/bin/perl

use strict;
use warnings;
use autodie;
use File::Find;
use Cwd;
use Sim::GA qw/energy_from_log cycles_from_log/;

my $rootdir = getcwd();

for my $chrom (glob backup/*) {
	chdir $chrom;
	my $energy = 0;
	my $cycles = 0;
	for my $logfile (glob *.out) {
		$energy += energy_from_log($logfile, $logfile, $chrom);
		$cycles += cycles_from_log($logfile, $logfile, $chrom);
	}
	open my $total, ">", "total";
	print $total "$energy\t$cycles\n";
	print "$chrom\t$energy\t$cycles\n";
	chdir($rootdir);
}
