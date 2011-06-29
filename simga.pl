#!/usr/bin/perl

use strict;
use warnings;

use AI::Genetic;
use List::Util qw/sum/;
use File::Find;
use Regexp::Common;
use File::Copy;

my $bmark = "eembc2";
my $scale = 1000; # we represent [0,1] as {0,1,2,...$scale}
my $quantum = 1/$scale; # quantum of gene variation
my $num_genes = 13;
$| = 1;

my $ecc_flags = $ENV{ECC_CC_FLAGS};

# Given a list of genes (numbers in range 0...$scale), get corresponding args
# to hand to ecc.
sub ecc_args {
	my @genes = map { $_ * $quantum } @_;
	return join " ", (
		"-bt", $genes[0],
		"-bw_noreturn", $genes[1],
		"-bw_non_equal", $genes[2],
		"-bw_pointer", $genes[3],
		"-bw_positive", $genes[4],
		"-bw_float", $genes[5],
		"-bw_call", $genes[6],
		"-bw_neg_return", $genes[7],
		"-bw_null_return", $genes[8],
		"-bw_const_return", $genes[9],
		"-bw_loop_header", $genes[10],
		"-bw_loop_branch", $genes[11],
		"-bw_loop_exit", $genes[12],
	);
}

sub backup {
	my $logfile = shift;
	my $genes = join ":", @_;
	if (! -d "backup") {
		mkdir "backup";
	}
	if (! -d "backup/$genes") {
		mkdir "backup/$genes";
	}
	(my $newfilename = $logfile) =~ s|/|:|g;
	move $logfile, "backup/$genes/$newfilename";
}

sub energy_from_log {
	my $filename = shift;
	my @genes = @_; # needed to provide sensible error messages
	my $energy = 0;
	my $seen = 0;
	open my $log, "<", $_[0];
	while (<$log>) {
		if (/BPU total energy\s*($RE{num}{real})\s*\(nJ\)/) {
			$energy += $1;
			$seen++;
		}
	}
	close $log;
	if ($seen != 1) {
		warn "Saw $seen 'total energy' lines in $filename for genes "
			. join(" ", @genes);
	}
	return $energy;
}

sub sum_energies {
	my @genes = @_; # needed to provide sensible error messages
	my $energy = 0;
	find(sub {
		if ($_ eq "sim.out") {
			$energy += energy_from_log($File::Find::name, @genes);
		}
		backup $File::Find::name, @genes;
	}, ".");
	return $energy;
}

# Fitness function. Build and run benchmarks with branch-prediction
# flags set appropriately, collect energy usage.
sub fitness {
	my @genes = @{$_[0]};
	$ENV{ECC_CC_FLAGS} = $ecc_flags . " " . ecc_args(@genes);
	print "ECC_CC_FLAGS: $ENV{ECC_CC_FLAGS}\n";
	system "make clean-$bmark";
	system "make run-$bmark";
	my $energy = sum_energies();
	return 1/($energy + 1);
}

my @ranges = ([0, $scale]) x ($num_genes - 1);
unshift @ranges, [0.5 * $scale, $scale]; # threshold > 0.5
my $ga = new AI::Genetic(
	-fitness => \&fitness,
	-type => 'rangevector',
	-population => 50,
);
$ga->init(\@ranges);
$ga->evolve('rouletteTwoPoint', 5);
my $best = $ga->getFittest();
print "Best score = ", $best->score, "\n";
print "obtained with genes " . join(" ", $best->genes()) . "\n";
