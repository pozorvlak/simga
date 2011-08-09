#!/usr/bin/perl

use strict;
use warnings;

use File::Path;
use Test::More;
use Sim::Constants;

ok -d "test", "Sanity check: test directory exists...";
chdir "test";
rmtree("backup");
ok !-d "backup", "Backup directory successfully deleted";
ok system( "../simga.pl --generations=1 --population=1 > out.ga 2>&1") == 0,
	"simga.pl returns shell-true status";
my @logfiles = glob("$Sim::Constants::bmark_dir/*/sim.out");

open my $outfile, "<", "out.ga";
local $/ = undef;
my $out = <$outfile>;

# Tests of logfile content
ok $out =~ /ECC_CC_FLAGS=/, "ECC_CC_FLAGS settings listed";
ok $out =~ /Best score/, "Best score shown";
ok $out =~ /with genes/, "Best genes listed";

ok -d "backup", "Backup directory created";

my @backup_logfiles = glob("backup/*/*sim.out");
is @logfiles, @backup_logfiles, "All log files backed up";

my @savefiles = glob("backup/*.sga");
ok @savefiles == 1, "One savefile created per completed generation";

done_testing();
