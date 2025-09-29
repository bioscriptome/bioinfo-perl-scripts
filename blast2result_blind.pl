#!/usr/bin/perl
use Getopt::Std;
getopts('p:n:f:d:t:y:');
$file=$opt_p;$neg=$opt_n;$fold=$opt_f;$db=$opt_d;$tag=$opt_t;$db1=$opt_y;
if($file eq '' ||$db eq '' ||$db1 eq ''||$neg eq ''){print "-p: positive fasta file; 
-n: number of hits to be considered 
-f: folder name in which to run process 
-y: pos database or engative (p/n)
-d: database folder path\n";}
else{
system "~/progs/fasta2sfasta -i $file -o $fold/sfasta ;cut -d '#' -f1 $fold/sfasta |cut -d '>' -f2 >$fold/tags";
system " ~/blast-2.2.24/bin/blastall -p blastp -d $db/AVP_543-i $file -F F -f 9 -b 1 -e 10 -m 8 |cut -f1,2,11|sort -u >$fold/out_pos";
system " ~/blast-2.2.24/bin/blastall -p blastp -d $db/NON-AVP_407 -i $file -F F -f 9 -b 1 -e 10 -m 8 |cut -f1,2,11|sort -u >$fold/out_neg";

}
open(POS,"$fold/out_pos");
open(NEG,"$fold/out_neg");
open(OPOS,">$fold/out_pos_NORM");
open(ONEG,">$fold/out_neg_NORM");
undef @pos,undef @neg;@pos=<POS>;@neg=<NEG>;close POS;close NEG;
open(TAG,"$fold/tags");undef @tags;@tags=<TAG>;
foreach $tags(@tags){
chomp($tags);
undef @get;undef $un;undef @get;$u=0;
foreach $un(@pos){chomp($un);if($un=~/^$tags\t.+\t.+/){$get[$u++]=$un."\n";}}
$size=0;$size=scalar(@get);
if($size eq 0){print OPOS $tags."\tNA\n";}
else{undef $add;foreach $line(@get){chomp($line);undef @cut;@cut=split("\t",$line);$add+=sprintf("%0.20f", $cut[2]);}print OPOS $tags."\t";printf (OPOS "%0.20f\n",$add);}
}
foreach $tags(@tags){
chomp($tags);
undef @get;undef $un;undef @get;$u=0;
foreach $un(@neg){chomp($un);if($un=~/^$tags\t.+\t.+/){$get[$u++]=$un."\n";}}
$size=0;$size=scalar(@get);
if($size eq 0){print ONEG $tags."\tNA\n";}
else{undef $add;foreach $line(@get){chomp($line);undef @cut;@cut=split("\t",$line);$add+=sprintf("%0.20f", $cut[2]);}print ONEG $tags."\t";printf (ONEG "%0.20f\n",$add);}
}


close ONEG;close OPOS;
open(FH,"$fold/out_pos_NORM");
open(FH1,"$fold/out_neg_NORM");
undef @array1;undef @array2;
@array1=<FH>;
@array2=<FH1>;
close FH1;close FH2;
#if($ARGV[0] eq ''){print "ARGV[0] : Positive DB Result\nARGV[1] : Negative DB Result File\n";}
#else{
if(scalar(@array1) eq scalar(@array2)){
$size=scalar(@array1);
for($i=0;$i<$size;$i++){
chomp($array1[$i]);
chomp($array2[$i]);
undef @split1;undef @split2;
@split1=split("\t",$array1[$i]);
@split2=split("\t",$array2[$i]);
#if(($split2[1] eq 'NA' && $split1[1] >0)||($split1[1] <$split2[1] && $split1[1] ne 'NA' )){print "$split1[0]\t1\t$array1[$i]\t$array2[$i]\n";}
#else{print "$split1[0]\t0\t$array1[$i]\t$array2[$i]\n";}
if(($split2[1] eq 'NA' && $split1[1] >0)||($split1[1] <$split2[1] && $split1[1] ne 'NA' )){print "$split1[0]\t1\n";}
else{print "$split1[0]\t0\n";}

}
}     
#}


