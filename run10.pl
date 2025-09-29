#!/usr/bin/perl 
use Getopt::Std;
getopts('i:p:f:t:g:r:j');
$file1=$opt_i;#input 0.56 CGGGCGAGCTCCCAAACTT

if($file1 eq ''){print '$opt_i=-i  file eff_seq
$opt_p=-p(mdttpb) program name if u have pattern file dont use this argument
$opt_f;=-f(5/10) fold to use
$opt_t;=-t (f/c)frequency or composition


'}else{
$run=$opt_r;
print $file2."\n";
system "rm  train_* test_* score_* set* averageRESULT* RESULT Main_data ";
system "perl ~/progs/sipred_progs/mk/split_10fold.pl  $file1";
system "perl ~/progs/sipred_progs/mk/traintest_10sets.pl";
system "perl ~/progs/sipred_progs/mk/score10.pl";
if($run=~/w/){
system "perl ~/progs/sipred_progs/mk/svmrunr10_sirna.pl ";
}
if($run=~/1/){
system "perl ~/progs/sipred_progs/mk/svmrunr1.pl ";
}
system "perl ~/progs/sipred_progs/mk/average10.pl";

}

