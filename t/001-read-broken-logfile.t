#!/usr/bin/perl

use strict;
use warnings;
use Test::More tests => 1;

use Sim::GA qw/energy_from_log/;
use Math::BigInt;

chdir "log";
ok(energy_from_log("error.log", "log/error.log")->is_inf,
	"Error in log => infinite energy use");
