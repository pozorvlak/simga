package Sim::Flags;
require Exporter;
@ISA = qw(Exporter);
@EXPORT_OK = qw(ecc_args);

# Given a list of genes (numbers in range 0...$scale), get corresponding args
# to hand to ecc.
sub ecc_args {
	my $granularity = shift;
	my @genes = map { $_ * $granularity } @_;
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

