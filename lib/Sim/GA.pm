package Sim::GA;

use strict;
use warnings;
use base 'Exporter';
our @EXPORT_OK = qw(energy_from_log cycles_from_log);
use Carp;
use Regexp::Common;
use Math::BigInt;

sub cycles_from_log {
	my $filename = shift;
	my $fullname = shift;
	return data_from_log($filename, $fullname,
		qr/cycle count\s*=\s*(\d*)/i,
		"cycle count",
		@_);
}

sub energy_from_log {
	my $filename = shift;
	my $fullname = shift;
	return data_from_log($filename, $fullname,
		qr/total energy\s*($RE{num}{real})\s*\(nJ\)/,
		"total energy",
		@_);
}

sub data_from_log {
	my $filename = shift;
	my $fullname = shift;
	my $regex = shift;
	my $message = shift;
	my @genes = @_; # needed to provide sensible error messages
	my $energy = 0;
	my $seen = 0;
	open my $log, "<", $filename or die "Couldn't open $filename: $!";
	while (<$log>) {
		if ($_ =~ $regex) {
			$energy += $1;
			$seen++;
		}
	}
	close $log;
	if ($seen != 1) {
		warn "Saw $seen '$message' lines in $fullname for genes "
			. join(" ", @genes);
			$energy += Math::BigInt::binf();
	}
	return $energy;
}


