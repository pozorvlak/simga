#!/usr/bin/perl

use strict;
use warnings;

use AI::Genetic;
use List::Util qw/sum/;
use File::Find;
use Regexp::Common;
use File::Copy;
use Cwd qw/abs_path getcwd/;
use Getopt::Long;
use Sim::GA qw/cycles_from_log/;
use Sim::Flags qw/ecc_args/;

my $bmark = "eembc2";
my $bmark_dir = "EEMBC/eembc-2.0";
my $scale = 100; # we represent [0,1] as {0,1,2,...$scale}
my $granularity = 1/$scale; # granularity of gene variation
my $num_genes = 13;
$| = 1;
my $root_dir = getcwd();
my $logfilename = "sim.out";

my $generations = 10;
my $population = 50;
my $nobuild = 0;
my $help = 0;
GetOptions ("generations=i" => \$generations,
            "population=i" => \$population,
	    "nobuild" => \$nobuild,
	    "help" => \$help);
if ($help) { usage(); }

my $ecc_flags = $ENV{ECC_CC_FLAGS};

sub usage {
	print <<END;

simga - run benchmarks under a genetic algorithm

options:
  --generations  number of generations to run (default 10)
  --nobuild      do not run benchmarks, just gather stats
  --population   population in a generation (default 50)
  --help         show this message

END
	exit 0;
}

sub backup {
	my $logfile = shift;
	my $fullname = shift;
	my $genes = join ":", @_;
	if (! -d "$root_dir/backup") {
		mkdir "$root_dir/backup";
	}
	if (! -d "$root_dir/backup/$genes") {
		mkdir "$root_dir/backup/$genes";
	}
	(my $newfilename = $fullname) =~ s|/|:|g;
	$newfilename =~ s/^.://;
	my $newfilepath = "$root_dir/backup/$genes/$newfilename";
	if (! -e $logfile) { warn "$logfile doesn't exist\n"; }
	copy $logfile, $newfilepath or warn "Couldn't copy: $!";
}

sub sum_cycles {
	my @genes = @_; # needed to provide sensible error messages
	my $cycles = 0;
	find(sub {
		if ($_ eq $logfilename) {
			$cycles += cycles_from_log($logfilename, @genes);
                        # passing in $_ leads to first arg being undefined...
			backup $logfilename, $File::Find::name, @genes;
		}
	}, $bmark_dir);
	return $cycles;
}

# Fitness function. Build and run benchmarks with branch-prediction
# flags set appropriately, collect energy usage.
sub fitness {
	my @genes = @{$_[0]};
	$ENV{ECC_CC_FLAGS} = $ecc_flags . " " . ecc_args($granularity, @genes);
	print "ECC_CC_FLAGS: $ENV{ECC_CC_FLAGS}\n";
	unless ($nobuild) {
		system "make -j clean-$bmark";
		system "make -j run-$bmark";
	}
	my $cycles = sum_cycles(@genes);
	return 1/($cycles + 1);
}

my @ranges = ([0, $scale]) x ($num_genes - 1);
unshift @ranges, [0.5 * $scale, $scale]; # threshold > 0.5
my $ga = new AI::Genetic(
	-fitness => \&fitness,
	-type => 'rangevector',
	-population => $population,
);
system("date");
$ga->init(\@ranges);
$ga->evolve('rouletteTwoPoint', $generations);
my $best = $ga->getFittest();
print "Best score = ", $best->score, "\n";
system("date");
print "obtained with genes " . join(" ", $best->genes()) . "\n";
