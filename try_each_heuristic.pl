#!/usr/bin/perl

use strict;
use warnings;
use Sim::Constants;
use Sim::Fitness;
use Cwd;

my $num_genes = $Sim::Constants::num_genes;
my $num_heuristics = $num_genes - 1; # zeroth gene is prediction threshold.

my $options = {
	ecc_flags => $ENV{ECC_CC_FLAGS},
	root_dir => getcwd(),
	target => "build",
	backup_matcher => qr/\.o$/,
};

my $fitness = Sim::Fitness::make_fitness($options);

my @geneses;
for my $i (1 .. $num_heuristics) {
	my @genes = (0.5, ("0.0000001") x $num_heuristics);
	$genes[$i] = 1;
	push @geneses, \@genes;
}

for my $genes (@geneses) {
	$fitness->($genes);
}
