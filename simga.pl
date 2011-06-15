#!/usr/bin/perl

use strict;
use warnings;

use AI::Genetic;
use List::Util qw/sum/;

my $bmark = "eembc2";
my $scale = 1000; # 1/(quantum of gene variation)
my $num_genes = 13;
$| = 1;

# Given a list of genes (numbers in range 0...$scale), get corresponding args
# to hand to ecc.
sub ecc_args {
	my @genes = map { $_ * $scale } @_;
	return <<"ARGS";
		-bv $genes[0]
		-bw_noreturn $genes[1]
		-bw_non_equal $genes[2]
		-bw_pointer $genes[3]
		-bw_positive $genes[4]
		-bw_float $genes[5]
		-bw_call $genes[6]
		-bw_neg_return $genes[7]
		-bw_null_return $genes[8]
		-bw_const_return $genes[9]
		-bw_loop_header $genes[10]
		-bw_loop_branch $genes[11]
		-bw_loop_exit $genes[12]
ARGS
}

{
my $times;
# Fitness function. Build and run benchmarks with branch-prediction
# flags set appropriately, collect energy usage.
sub fitness {
	if (($times++ % 100) == 0) {
		print ".";
	}
	my @genes = @{$_[0]};
	$ENV{ECC_CC_FLAGS} .= ecc_args(@genes);
	# system "make clean-$bmark";
	# system "make collect-$bmark";
	# open my $fh, "<", "energy";
	# my $energy = <$fh>;
	my $energy = sum(map { ($_ - 500)**2 } @genes);
	return 1/($energy + 1);
}
}

my @ranges = ([0, $scale]) x $num_genes;
my $ga = new AI::Genetic(
	-fitness => \&fitness,
	-type => 'rangevector',
);
$ga->init(\@ranges);
$ga->evolve('rouletteTwoPoint', 100);
my $best = $ga->getFittest();
print "Best score = ", $best->score, "\n";
print "obtained with genes " . join(" ", $best->genes()) . "\n";
