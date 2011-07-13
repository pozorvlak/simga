package Sim::GA;
require Exporter;
@ISA = qw(Exporter);
@EXPORT_OK = qw(energy_from_log cycles_from_log);

use strict;
use warnings;
use Carp;
use Regexp::Common;

sub cycles_from_log {
	my $filename = shift;
	return data_from_log($filename,
		qr/cycle count\s*=\s*(\d*)/i,
		"cycle count",
		@_);
}

sub energy_from_log {
	my $filename = shift;
	return data_from_log($filename,
		qr/BPU total energy\s*($RE{num}{real})\s*\(nJ\)/,
		"total energy",
		@_);
}

sub data_from_log {
	my $filename = shift;
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
		warn "Saw $seen '$message' lines in $File::Find::name for genes "
			. join(" ", @genes);
	}
	return $energy;
}


