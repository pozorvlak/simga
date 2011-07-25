package Sim::Backup;

use File::Copy;
use File::Find;
use Cwd qw/abs_path getcwd/;
require Exporter;
@ISA = qw(Exporter);
@EXPORT_OK = qw(backup backup_all genes_to_dirname);

my $logfilename = "sim.out";

sub genes_to_dirname {
	return join ":", @_;
}

sub backup {
	my ($root_dir, $logfile, $fullname, @genes) = @_;
	my $genes = genes_to_dirname(@genes);
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

1;
