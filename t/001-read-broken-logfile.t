#!/usr/bin/perl

use strict;
use warnings;
use Test::More tests => 2;
use Test::Warn;

use Sim::LogReader qw/energy_from_log/;
use Math::BigInt;

chdir "log";
my $energy;
warning_like { $energy = energy_from_log("error.log", "log/error.log") }
	qr|Saw 0 'total energy' lines in log/error.log|,
	"Warning thrown if no 'total energy' lines are found";
ok($energy->is_inf, "Error in log => infinite energy use");
