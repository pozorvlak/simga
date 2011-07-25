#!/usr/bin/perl

use strict;
use warnings;
use Sim::Flags 'ecc_args';

print <<END_BOILERPLATE;
#!/usr/bin/perl

use strict;
use warnings;
use Sim::Flags 'ecc_args';
use Test::More tests => 20;

END_BOILERPLATE

for my $chrom (0 .. 19) {
	my $scale = 100;
	my $granularity = 1/$scale;
	my @genes = map { int(rand($scale)) } (0 .. 12);
	my $args = join(", ", $granularity, @genes);
	print "is(ecc_args($args),\n'". ecc_args($granularity, @genes)."');\n";
}

