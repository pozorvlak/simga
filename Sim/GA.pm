package Sim::GA;
require Exporter;
@ISA = qw(Exporter);
@EXPORT_OK = qw(energy_from_log);

use strict;
use warnings;
use Carp;
use Regexp::Common;

sub energy_from_log {
	my $filename = shift;
	my @genes = @_; # needed to provide sensible error messages
	my $energy = 0;
	my $seen = 0;
	open my $log, "<", $filename or die "Couldn't open $filename: $!";
	while (<$log>) {
		if (/BPU total energy\s*($RE{num}{real})\s*\(nJ\)/) {
			$energy += $1;
			$seen++;
		}
	}
	close $log;
	if ($seen != 1) {
		warn "Saw $seen 'total energy' lines in $filename for genes "
			. join(" ", @genes);
	}
	return $energy;
}


