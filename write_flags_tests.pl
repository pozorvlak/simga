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

for my $chrom (0 .. 20) {
	my $granularity;
	while ($granularity = rand) {
		last if $granularity > 0;
	}
	my @genes = map { rand } (0 .. 12);
	my $args = join(", ", $granularity, @genes);
	print "is(ecc_args($args),\n'". ecc_args($granularity, @genes)."');\n";
}

