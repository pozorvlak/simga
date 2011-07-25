package Sim::Generations;
require Exporter;
@ISA = qw(Exporter);
@EXPORT_OK = ();

use strict;
use warnings;
use Carp;
use Sim::Flags 'parse_args';

sub generations {
	my ($granularity, $logfile, $population) = @_;
	my @generations;
	my $generation = 0;
	my $seen = 0;
	open my $log, "<", $logfile or croak "Can't open $logfile for reading: $!";
	while (my $line = <$log>) {
		if ($line =~ /ECC_CC_FLAGS/) {
			my @genes = parse_args($granularity, $line);
			push @{$generations[$generation]}, \@genes;
			$seen++;
			if (($seen % $population) == 0) {
				$generation++;
			}
		}
	}
	close $log;
	return @generations;
}

1;
