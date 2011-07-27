package Sim::Flags;

use strict;
use warnings;
use base 'Exporter';
our @EXPORT_OK = qw(ecc_args parse_args);
use Carp;
use Regexp::Common;
use POSIX qw/floor ceil/;

sub round {
	my $x = shift;
	my $f = floor($x);
	my $c = ceil($x);
	if (($x - $f) > ($c - $x)) {
		return $c;
	} else {
		return $f;
	}
}


my @flag_names = (
	"-bt",
	"-bw_noreturn",
	"-bw_non_equal",
	"-bw_pointer",
	"-bw_positive",
	"-bw_float",
	"-bw_call",
	"-bw_neg_return",
	"-bw_null_return",
	"-bw_const_return",
	"-bw_loop_header",
	"-bw_loop_branch",
	"-bw_loop_exit",
);


# Given a list of genes (numbers in range 0...$scale), get corresponding args
# to hand to ecc.
sub ecc_args {
	my $granularity = shift;
	my @genes = map { $_ * $granularity } @_;
	@genes = map { $_ == 0 ? $granularity ** 2 : $_ } @genes;
	carp "Expected ".scalar(@flag_names)." genes, got ".scalar(@genes)
		unless $#flag_names == $#genes;
	return join(" ", map { $flag_names[$_], $genes[$_] } (0 .. $#genes));
}

# The inverse function. Given a value of ECC_CC_FLAGS, give the genes that gave
# rise to it.
sub parse_args {
	my ($granularity, $argstring) = @_;
	my @genes;
	for my $i (0 .. $#flag_names) {
		$argstring =~ /$flag_names[$i]\s+($RE{num}{real})/
			or carp "No value for flag $flag_names[$i] in flag specification '$argstring'";
		$genes[$i] = $1;
	}
	return map { round($_ / $granularity) } @genes;
}

1;
