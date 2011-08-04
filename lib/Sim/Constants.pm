package Sim::Constants;

my $bmark = "eembc2";
my $bmark_dir = "EEMBC/eembc-2.0";
my $scale = 100; # we represent [0,1] as {0,1,2,...$scale}
my $granularity = 1/$scale; # granularity of gene variation
my $num_genes = 13;
my $logfilename = "sim.out";

1;
