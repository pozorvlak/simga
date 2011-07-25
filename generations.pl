#!/usr/bin/perl

use strict;
use warnings;
use Sim::Generations;
use Getopt::Long;
use Data::Dumper;
use File::Spec::Functions;
use Sim::Backup 'genes_to_dirname';

sub usage {
	print <<END;
  Usage: $0
    [--population p (default 50)]
    [--backup backup_dir (default "backup")]
    [--prefix prefix_for_generation_files ]
    [--granularity g (default 0.01) ]
    logfile.ga
END
	exit 1;
}

sub getopts {
	if (@ARGV < 1) {
		usage();
	}
	my ($population, $backup_dir, $prefix);
	# (my $backup_dir = "backup.$logfile") =~ s/.ga$//;
	# my $prefix = "$backup_dir/generation_";
	$population = 50;
	my $granularity = 0.01;
	GetOptions("population=i" => \$population,
		   "backup=s" => \$backup_dir,
		   "prefix=s" => \$prefix,
		   "granularity=i" => \$granularity);
	my $logfile = $ARGV[0];
	return ($granularity, $logfile, $population, $backup_dir, $prefix);
}

my ($granularity, $logfile, $population, $backup_dir, $prefix) = getopts();
my @generations = Sim::Generations::generations(
	$granularity, $logfile, $population);
for my $gen (0 .. $#generations) {
	open my $fh, ">", "$prefix$gen";
	for my $chrom (@{$generations[$gen]}) {
		print $fh catfile($backup_dir, genes_to_dirname(@$chrom));
		print $fh "\n";
	}
}

