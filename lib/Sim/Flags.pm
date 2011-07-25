package Sim::Flags;
require Exporter;
@ISA = qw(Exporter);
@EXPORT_OK = qw(ecc_args);
use Carp;

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
	carp "Expected ".scalar(@flag_names)." genes, got ".scalar(@genes)
		unless $#flag_names == $#genes;
	return join(" ", map { $flag_names[$_], $genes[$_] } (0 .. $#genes));
}

# The inverse function. Given a value of ECC_CC_FLAGS, give the genes that gave
# rise to it.
sub parse_args {
}

1;
