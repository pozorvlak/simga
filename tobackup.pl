#!/usr/bin/perl

use strict;
use warnings;

use Sim::Backup 'backup_all';

my $bmark_dir = "EEMBC/eembc-2.0";
backup_all($bmark_dir);
