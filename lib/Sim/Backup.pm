package Sim::Backup;

use strict;
use warnings;
use base 'Exporter';
our @EXPORT_OK = qw(backup backup_all genes_to_dirname savefile_name);
use File::Copy;
use File::Find;
use File::Spec;
use Sim::Constants;

my $logfilename = $Sim::Constants::logfilename;

sub genes_to_dirname {
	return join ":", @_;
}

sub mkdir_unless_exists {
	my $dirname = shift;
	if (! -d $dirname) {
		mkdir $dirname or die "Couldn't make $dirname: $!";
	}
}

sub backup {
	my ($root_dir, $logfile, $fullname, @genes) = @_;
	my $genes = genes_to_dirname(@genes);
	my $backup_dir = $Sim::Constants::backup_dir;
	my $rel_backup_dir = File::Spec->catfile($root_dir, $backup_dir);
	my $gene_dir = File::Spec->catfile($rel_backup_dir, $genes);
	print "Backing up to $gene_dir\n";
	mkdir_unless_exists $rel_backup_dir;
	mkdir_unless_exists $gene_dir;
	(my $newfilename = $fullname) =~ s|/|:|g;
	$newfilename =~ s/^.://;
	my $newfilepath = File::Spec->catfile($gene_dir, $newfilename);
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
	mkdir_unless_exists($Sim::Constants::backup_dir);
	return File::Spec->catfile($Sim::Constants::backup_dir,
		"state_$generation.sga");
}

1;
