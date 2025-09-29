#!/usr/bin/perl

$pw = `pwd`;
chomp($pw);

for ($a=63;$a<=73;$a+=2)
{
system "~/softy/velvet_1.2.03/velveth velveth_$a/ $a -fastq -shortPaired RKJ300_CAGATC_L003_filtered_trim_shuflle.fastq";

system "~/softy/velvet_1.2.03/velvetg velveth_$a/ -cov_cutoff auto -ins_length 350 -ins_length_sd 50 -min_contig_lgth 200  -scaffolding yes -read_trkg yes -exp_cov 267 -very_clean yes";

}
