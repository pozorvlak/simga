package Sim::Backup;

use strict;
use warnings;
use base 'Exporter';
our @EXPORT_OK = qw(backup backup_all genes_to_dirname);
use File::Copy;
use File::Find;
use Sim::Constants;
use Cwd;

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
	my $options = shift;
	my @genes = @_; # needed to provide sensible error messages
	my $bmark_dir = $Sim::Constants::bmark_dir;
	my $root_dir = getcwd();
	my $matcher = $options->{backup_matcher} || $logfilename;
	find(sub {
		if ($File::Find::name =~ $matcher) {
			my $filename = $_;
			backup $root_dir, $filename, $File::Find::name, @genes;
		}
	}, $bmark_dir);
}

1;
