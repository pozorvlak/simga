package Sim::Constants;

our $bmark = "eembc2";
our $bmark_dir = "EEMBC/eembc-2.0";
our $scale = 100; # we represent [0,1] as {0,1,2,...$scale}
our $granularity = 1/$scale; # granularity of gene variation
our $num_genes = 13;
our $logfilename = "sim.out";

1;
