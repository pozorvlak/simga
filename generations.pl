#!/usr/bin/perl

use strict;
use warnings;
use Sim::Generations;
use Getopt::Long;

sub usage {
	print "Usage: $0 [--population p] [--backup backup_dir] logfile.ga";
}

sub getopts {
	if ($ARGC < 1) {
		usage();
	}
	my $logfile = $ARGV[0];
	my $population = 50;
	(my $backup_dir = "backup.$logfile") =~ s/.ga$//;
	GetOptions("population=i" => \$population,
		   "backup=s" => \$backup_dir,
		   "prefix=s" => );
	return ($logfile, $population, $backup_dir, $prefix);
}

my ($logfile, $population, $backup_dir) = getopts();
my @generations = Sim::Generations::generations(
			logfile => $ARGV[0],
			population => $population,
			backup_dir => $backup_dir);

