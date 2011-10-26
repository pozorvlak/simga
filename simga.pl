#!/usr/bin/perl

use strict;
use warnings;

use AI::Genetic;
use List::Util qw/sum/;
use Regexp::Common;
use Cwd qw/abs_path getcwd/;
use Getopt::Long;
use Sim::Constants;
use Sim::Fitness qw/make_fitness/;
use Sim::Backup qw/genes_to_dirname/;
use Math::BigInt;

my $scale = $Sim::Constants::scale;
my $num_genes = $Sim::Constants::num_genes;
$| = 1;
my $root_dir = getcwd();
my $generations = 10;
my $population = 50;
my $nobuild = 0;
my $help = 0;
my $optimize_for_cycles = 0;
GetOptions ("generations=i" => \$generations,
            "population=i" => \$population,
	    "nobuild" => \$nobuild,
	    "help" => \$help,
	    "cycles" => \$optimize_for_cycles);
if ($help) { usage(); }

my $ecc_flags = $ENV{ECC_CC_FLAGS};

my $options = {
	root_dir => $root_dir,
	generations => $generations,
	population => $population,
	nobuild => $nobuild,
	optimize_for_cycles => $optimize_for_cycles,
	ecc_flags => $ecc_flags,
};

sub usage {
	print <<END;

simga - run benchmarks under a genetic algorithm

options:
  --cycles       optimize for cycle count (default is energy usage)
  --generations  number of generations to run (default 10)
  --nobuild      do not run benchmarks, just gather stats
  --population   population in a generation (default 50)
  --help         show this message

END
	exit 0;
}


my @ranges = ([0, $scale]) x ($num_genes - 1);
unshift @ranges, [0.5 * $scale, $scale]; # threshold > 0.5
my $ga = new AI::Genetic(
	-fitness => make_fitness($options),
	-type => 'rangevector',
	-population => $population,
);
if (defined $ENV{ARCHFILE}) {
	print "Architecture file: $ENV{ARCHFILE}\n";
} else {
	print "Architecture file unspecified, using default.\n";
}
system("date");
$ga->init(\@ranges);
$ga->evolve('rouletteTwoPoint', $generations);
my $best = $ga->getFittest();
print "Best score = ", $best->score, "\n";
system("date");
print "obtained with genes " . genes_to_dirname($best->genes()) . "\n";
