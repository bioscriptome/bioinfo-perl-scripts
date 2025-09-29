#!/usr/bin/perl
use Getopt::Std;
getopts('p:n:m:e:f:t:');

$pos=$opt_p;
$neg=$opt_n;
$motif=$opt_m;
$eval=$opt_e;
$fold=$opt_f;
$tag=$opt_t;

if($pos eq '' ||$neg eq '' ||$motif eq ''||$eval eq '' ||$fold eq '' ||$tag eq ''){print "-p: positive fasta file; 
-n: negative fasta file
-f: folder name in which to run process 
-m: Motif file (p/n)
-d: database folder path\n";}
else{

system "rm -rf $fold pos_$fold neg_$fold; mkdir $fold";
system "perl ~/progs/fasta2sfasta -i $pos -o $fold/POS.sfasta";
system "perl ~/progs/fasta2sfasta -i $neg -o $fold/NEG.sfasta";
system "perl ~/progs/meme_mast.pl -p $pos -n pos  -m $motif -e $eval  -f $fold\_pos -t pos";
system "perl ~/progs/meme_mast.pl -p $neg -n pos  -m $motif -e $eval  -f $fold\_neg -t neg";

system "egrep -f $fold\_pos/left_out_pos $fold/POS.sfasta >$fold/left_pos.sfasta";
system "egrep -f $fold\_neg/left_out_neg $fold/NEG.sfasta >$fold/left_neg.sfasta";
system "perl ~/progs/pro2aac_svm -i $fold/left_pos.sfasta -o $fold/left_pos.svm -t +1";
system "perl ~/progs/pro2aac_svm -i $fold/left_neg.sfasta -o $fold/left_neg.svm -t -1";

}
