#!/usr/bin/perl

use strict;
use warnings;
use Sim::Generations qw/generations getopts/;
use Data::Dumper;
use File::Spec::Functions;
use Sim::Backup 'genes_to_dirname';

sub usage {
	print <<END;
  Usage: $0
    [--population p (default 50)]
    [--backup backup_dir (default "backup.\$logfile" with ".ga" stripped)]
    [--prefix prefix_for_generation_files (default "backup/generation_")]
    [--granularity g (default 0.01) ]
    logfile.ga
END
	exit 1;
}

my ($granularity, $logfile, $population, $backup_dir, $prefix) = getopts();
die "Backup directory $backup_dir does not exist" unless -d $backup_dir;
die "Logfile $logfile does not exist" unless -f $logfile;
my @generations = generations($granularity, $logfile, $population);
for my $gen (0 .. $#generations) {
	open my $fh, ">", "$prefix$gen"
	       	or die "Couldn't open $prefix$gen: $!";
	for my $chrom (@{$generations[$gen]}) {
		print $fh catfile($backup_dir, genes_to_dirname(@$chrom));
		print $fh "\n";
	}
	close $fh;
}

