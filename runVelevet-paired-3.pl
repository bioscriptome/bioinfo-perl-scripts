#!/usr/bin/perl

$pw = `pwd`;
chomp($pw);

for ($a=71;$a<=77;$a+=2)
{
system "/home/surendravikram/velvet_1.2.03/velveth out-$a/ $a -fasta -shortPaired ../shuffled-trimed.fa";

system "/home/surendravikram/velvet_1.2.03/velvetg out-$a/ -cov_cutoff auto -ins_length 350 -ins_length_sd 50 -min_contig_lgth 200  -scaffolding yes -read_trkg yes -exp_cov 267 -very_clean yes";

}
