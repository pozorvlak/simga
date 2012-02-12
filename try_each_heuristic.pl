#!/usr/bin/perl

use strict;
use warnings;
use Sim::Constants;
use Sim::Fitness;
use Cwd;
use Sim::Flags;
use File::stat;

# Refuse to run unless you've rebuilt librt since updating the compiler.
my $acc = `which acc`; chomp $acc;
my $acc_mtime = stat($acc)->mtime;
my $librt_mtime = stat("/disk/scratch/ecc/build/libs/build/lib/librt.a")->mtime;
if ($librt_mtime <= $acc_mtime) {
	warn "\nRebuild librt to reflect compiler changes!\n\n";
	exit 1;
}

my $num_genes = $Sim::Constants::num_genes;
my $num_heuristics = $num_genes - 1; # zeroth gene is prediction threshold.

my $options = {
	ecc_flags => $ENV{ECC_CC_FLAGS},
	root_dir => getcwd(),
	target => "build",
	backup_matcher => qr|/bin/.+|,
};

my $fitness = Sim::Fitness::make_fitness($options);

my @geneses;
for my $i (1 .. $num_heuristics) {
	my @genes = (0.5, ("0.5") x $num_heuristics);
	$genes[$i] = 1;
	push @geneses, \@genes;
}

for my $genes (@geneses) {
	$fitness->($genes);
}

# rename directories in backup/ to reflect heuristic names.
if (-d "backup") {
	chdir "backup";
}

for my $dir (glob("*")) {
	my @genes = split /:/, $dir;
	for my $i (0 .. $#genes) {
		if ($genes[$i] == 1) {
			my $heuristic = $Sim::Flags::flag_names[$i];
			$heuristic =~ s/^-//;
			print "Moving $dir to $heuristic\n";
			rename $dir, $heuristic;
		}
	}
}
