#!/usr/bin/perl 
use Getopt::Std;
getopts('i:p:f:t:g:r:j');
$file1=$opt_i;#input 0.56 CGGGCGAGCTCCCAAACTT
$file2=$opt_p;#program
$file2=~s/\s//g;
$fold=$opt_f; #fold
$f_or_c=$opt_t;#classification or regression
$filej=$opt_j;
$run=$opt_r;
#$file5=$opt_c;
print $file2."\n";
#$file6=$opt_g;
#$file7=$opt_j;
$fold1="split_".$fold."fold.pl";
if($f_or_c=~/f/){
%Type=('m'=>'mono_4.pl',
'd'=>'dinuc.pl','t'=>'trinuc.pl','bin'=>'compo_binnt.pl','tet'=>'tetra.pl','p'=>'penta.pl','md'=>'md.pl','mt'=>'mt.pl','mtet'=>'mtet.pl','mdt'=>'mdt.pl','mdttpb'=>'hybrid_mdttpb1440_freq.pl','mdttp'=>'hybrid_mdttp1364_freq.pl');}
if($f_or_c=~/c/){%Type=('m'=>'compo_monont.pl','d'=>'compo_dint.pl','t'=>'compo_trint.pl','tet'=>'tetra.pl','bin'=>'compo_binnt.pl','p'=>'penta.pl','md'=>'md.pl','mt'=>'mt.pl','mtet'=>'mtet.pl','mdt'=>'mdt.pl','mdtt'=>'hybrid_monoditritetra_c.pl','mdttp'=>'hybrid_mdttp1364_c.pl');}
$type=$Type{$file2};

if($file1 ne ''){
system "rm $file2";
system "perl ~/progs/sipred_progs/mk/$type $file1 $file2";
if($file2 ne ''){ "\nsystem \"perl ~/progs/sipred_progs/mk/$type $file1 $file2";
	     }
print "\t".$type."   typ\n";
if($file2 eq ''){$file2=$file1;}
system "rm  train_* test_* score_* set* averageRESULT* RESULT Main_data ";
system "perl ~/progs/sipred_progs/mk/$fold1  $file2";
system "perl ~/progs/sipred_progs/mk/traintest_$fold\sets.pl";
system "perl ~/progs/sipred_progs/mk/score$fold.pl ";
if($run=~/w/){
system "perl ~/progs/sipred_progs/mk/svmrunr$fold\_sirna.pl ";
}
if($run=~/1/){
system "perl ~/progs/sipred_progs/mk/svmrunr1.pl ";
}
system "perl ~/progs/sipred_progs/mk/average$fold.pl";



}
if($file1 eq ''){print '$opt_i=-i  file eff_seq
$opt_p=-p(mdttpb) program name if u have pattern file dont use this argument
$opt_f;=-f(5/10) fold to use
$opt_t;=-t (f/c)frequency or composition


'}
