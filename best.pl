#!/usr/bin/perl

use strict;
use warnings;
use Math::BigInt;
use autodie;

# Script to take the files produced by generations.pl and find the
# best-performing entry per generation, for plotting.

for my $dir (@ARGV) {
	open my $bestfile, ">", "$dir/best";
	print $bestfile "generation\tenergy\n";
	for my $genfile (glob "$dir/generation*") {
		(my $gen_number = $genfile) =~ s/.*generation_//;
		print "Generation $gen_number\n";
		open my $fh, "<", $genfile;
		my $best_energy = Math::BigInt->binf();
		CHROM: while (my $chrom = <$fh>) {
			chomp $chrom;
			unless (-d $chrom) {
				print STDERR "Chromosome $chrom doesn't exist ".
					"at generation $gen_number";
				next CHROM;
			}
			open my $total, "<", "$chrom/total";
			my $totals = <$total>;
			my ($energy, $cycles) = split /\s+/, $totals;
			if ($energy < $best_energy) {
				$best_energy = $energy;
			}
		}
		close $fh;
		print $bestfile "$gen_number\t$best_energy\n";
	}
}
