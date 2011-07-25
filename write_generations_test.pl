#!/usr/bin/perl

use strict;
use warnings;
use Sim::Flags 'ecc_args';

my $scale = 100;
my $granularity = 1/$scale;
my $logfile =  "log/generations.ga";
my $pop = 50;

open my $log, ">", $logfile;
open my $test, ">", "t/004-generations.t";
print $test <<END_BOILERPLATE;
#!/usr/bin/perl

use strict;
use warnings;
use Sim::Generations;
use Test::More tests => 1;

is_deeply([Sim::Generations::generations($granularity, "$logfile", $pop)], [
[
END_BOILERPLATE

for my $chrom (0 .. 200) {
	my @genes = map { int(rand($scale)) } (0 .. 12);
	my $args = join(", ", @genes);
	my $argstring = ecc_args($granularity, @genes);
	print $log "ECC_CC_FLAGS='$argstring'\n";
	print $log "Nothing to see here.\nPlease move along.\n";
	if (($chrom % $pop == 0) && $chrom > 0) {
		print $test "], [\n";
	}
	print $test "[$args],\n";
}
print $test "]\n]);"
