package Sim::Generations;

use strict;
use warnings;
use base 'Exporter';
our @EXPORT_OK = qw(generations getopts);
use Getopt::Long;
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

sub getopts {
	if (@ARGV < 1) {
		usage();
	}
	my ($population, $backup_dir, $prefix);
	$population = 50;
	my $granularity = 0.01;
	GetOptions("population=i" => \$population,
		   "backup=s" => \$backup_dir,
		   "prefix=s" => \$prefix,
		   "granularity=i" => \$granularity);
	my $logfile = $ARGV[0];
	if (!defined($backup_dir)) {
		($backup_dir = "backup.$logfile") =~ s/.ga$//;
	}
	if (!defined($prefix)) {
		$prefix = "$backup_dir/generation_";
	}
	return ($granularity, $logfile, $population, $backup_dir, $prefix);
}

1;
