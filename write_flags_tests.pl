#!/usr/bin/perl

use strict;
use warnings;
use Sim::Flags 'ecc_args';

print <<END_BOILERPLATE;
#!/usr/bin/perl

use strict;
use warnings;
use Sim::Flags qw/ecc_args parse_args/;
use Test::More tests => 40;

END_BOILERPLATE

for my $chrom (0 .. 19) {
	my $scale = 100;
	my $granularity = 1/$scale;
	my @genes = map { int(rand($scale)) } (0 .. 12);
	my $args = join(", ", @genes);
	my $argstring = ecc_args($granularity, @genes);
	print "is(ecc_args($granularity, $args),\n'$argstring');\n";
	print "is_deeply([parse_args($granularity, '$argstring')], [$args]);\n";
}

