package Sim::Backup;

use strict;
use warnings;
use base 'Exporter';
our @EXPORT_OK = qw(backup backup_all genes_to_dirname savefile_name);
use File::Copy;
use File::Find;
use File::Spec;

my $logfilename = "sim.out";

sub genes_to_dirname {
	return join ":", @_;
}

sub backup {
	my ($root_dir, $logfile, $fullname, @genes) = @_;
	my $genes = genes_to_dirname(@genes);
	print "Backing up to $root_dir/backup/$genes\n";
	if (! -d "$root_dir/backup") {
		mkdir "$root_dir/backup";
	}
	if (! -d "$root_dir/backup/$genes") {
		mkdir "$root_dir/backup/$genes";
	}
	(my $newfilename = $fullname) =~ s|/|:|g;
	$newfilename =~ s/^.://;
	my $newfilepath = "$root_dir/backup/$genes/$newfilename";
	if (! -e $logfile) { warn "$logfile doesn't exist\n"; }
	copy $logfile, $newfilepath or warn "Couldn't copy: $!";
}

sub backup_all {
	my $bmark_dir = shift;
	my @genes = @_; # needed to provide sensible error messages
	my $root_dir = getcwd();
	find(sub {
		if ($_ eq $logfilename) {
			backup $root_dir, $logfilename, $File::Find::name, @genes;
		}
	}, $bmark_dir);
}

sub savefile_name {
	my ($generation) = @_;
	return "backup/state_$generation.sga";
}

1;
