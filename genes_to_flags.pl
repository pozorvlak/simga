#!/usr/bin/perl

use strict;
use warnings;
use Sim::Flags 'ecc_args';

foreach (@ARGV) {
	my @genes = split /:/;
	print ecc_args(0.01, @genes) . "\n";
}
