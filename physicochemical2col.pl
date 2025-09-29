#!/usr/bin/perl
use Getopt::Std;
getopts('p:n:b:d:l:');
$positive=$opt_p;
$negative=$opt_n;
$bp=$opt_b;
$bn=$opt_d;
$list=$opt_l;
if($positive eq '' ||$negative eq '' || $list eq ''){print "-p: positive sfasta file; 
-n: negative sfasta file 
-b: blind positive sfasta file
-d: blind negative sfasta file
-l: file having list of properties;
";}
else{
open(FH3,$list);#file having the PhysicoChemical_aaindex1 idsst 
@properties=<FH3>;close FH1,FH2,FH3;
system "mkdir ./temp"; 
$paste1='paste -d \',\'';
$paste2='paste -d \',\'';
$blind1='paste -d \',\'';
$blind2='paste -d \',\'';
$size=scalar(@properties);
foreach $id(@properties){
    chomp($id);
    $paste1.=" ./temp/positve.$id";
    $paste2.=" ./temp/negative.$id";
    $blind1.=" ./temp/b_positve.$id";
    $blind2.=" ./temp/b_negative.$id";
    system "perl ~/progs/physicoChemical.pl ~/Matrix/physico/physicochemical_544/$id $positive >./temp/positve.$id ";
    system "perl ~/progs/physicoChemical.pl ~/Matrix/physico/physicochemical_544/$id $negative >./temp/negative.$id ";
    if($bp eq '' ||$bn eq ''){}
    else{
	system "perl ~/progs/physicoChemical.pl ~/Matrix/physico/physicochemical_544/$id $bp >./temp/b_positve.$id ";
	system "perl ~/progs/physicoChemical.pl ~/Matrix/physico/physicochemical_544/$id $bn >./temp/b_negative.$id ";
      } 
}
$paste1.=" >positive.physico$size";
$paste2.=" >negative.physico$size";
$blind1.=" >blind_pos.physico$size";
$blind2.=" >blind_neg.physico$size";

system "$paste1";
system "$paste2";
system "$blind1";
system "$blind2";
system " ~/gpsr_1.0/bin/col2svm -i positive.physico$size -o positive_physico$size.svm -s +1";
system " ~/gpsr_1.0/bin/col2svm -i negative.physico$size -o negative_physico$size.svm -s -1";
system " ~/gpsr_1.0/bin/col2svm -i blind_pos.physico$size -o blind_pos_physico$size.svm -s +1";
system " ~/gpsr_1.0/bin/col2svm -i blind_neg.physico$size -o blind_neg_physico$size.svm -s -1";
}

