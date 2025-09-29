#!/usr/bin/perl
use Getopt::Std;
getopts('p:n:f:d:t:y:');

$pos=$opt_p;
$neg=$opt_n;
$fold=$opt_f;
$db=$opt_d;
$tag=$opt_t;
$dbt=$opt_y;
if($pos eq '' ||$db eq '' ||$dbt eq ''||$neg eq ''){print "-p: positive fasta file; 
-n: number of hits to be considered 
-f: folder name in which to run process 
-y: pos database or engative (p/n)
-d: database folder path\n";}
else{
if($dbt eq 'p' ){$db1="AVP_412";}
if($dbt eq 'n'){$db1="AVP__dir_NEG_376";}
#if($dbt eq 'p' ){$db1="AVP_624";}
#if($dbt eq 'n'){$db1="plos_one";}
#if($dbt eq 'p' ){$db1="AVP_372";}
#if($dbt eq 'n'){$db1="NAVP_pone_375";}

system "~/progs/fasta2sfasta -i $pos -o $fold/sfasta ;cut -d '#' -f1 $fold/sfasta |cut -d '>' -f2 >$fold/tags";
system " ~/blast-2.2.24/bin/blastall -p blastp -d $db/$db1 -i $pos -F F -f 9 -b $neg -e 1000 -m 8 |cut -f1,2,11|sort -u >$fold/$tag\_pos";
#system " ~/blast-2.2.24/bin/blastall -p blastp -d $db/AVP__dir_NEG_376 -i $pos -F F -f 9  -b 3 -m 8 |cut -f1,2,11|sort -u>$fold/$tag\_neg"; 
#system " ~/blast-2.2.24/bin/blastall -p blastp -d $db/AVP_412 -i $neg -F F -f 9   -m 8 |cut -f1,2,11>$fold/out_pos_$neg"; 
#system " ~/blast-2.2.24/bin/blastall -p blastp -d $db/AVP__dir_NEG_376 -i $neg -F F -f 9   -m 8 |cut -f1,2,11>$fold/out_neg_$neg";
}
open(POS,"$fold/$tag\_pos");
open(NEG,"$fold/$tag\_neg");
undef @pos,
undef @neg;
@pos=<POS>;
@neg=<NEG>;
close POS;close NEG;
#system "cat $fold/$tag\_pos $fold/$tag\_neg |cut -f1 |sort -u >$fold/tags";
# $result = sprintf("%08d", $number);
open(TAG,"$fold/tags");
undef @tags;
@tags=<TAG>;
foreach $tags(@tags){
chomp($tags);
undef @get;
#@get=grep "$tags\t,@pos;
#@get=grep{$_ =~ /^$tags	/} @pos;
undef $un;
undef @get;
$u=0;
foreach $un(@pos){
chomp($un);
if($un=~/^$tags\t.+\t.+/){
$get[$u++]=$un."\n";
}
}
#@=map($_=~s/ //g,@get);
#@ = map { ($x = $_) =~ s/ //g;    
 #                  $x; 
  #               } @get;

#nprint "@get\n";
$size=0;
$size=scalar(@get);
#open(GG,@get);
if($size eq 0){print $tags."\tNA\t";print "@get\n";}
else{undef $add;
foreach $line(@get){
chomp($line);
undef @cut;
@cut=split("\t",$line);
#def($add);
#print "$cut[2]";
#print "\n";
$add+=sprintf("%0.20f", $cut[2]);

}
print $tags."\t";
printf ("%0.20f\n",$add);
}
}

sub def(){
@var=@_;
foreach $var(@var){
undef $var;
$var="";
}
}

