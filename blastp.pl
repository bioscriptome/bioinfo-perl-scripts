#!/usr/bin/perl
use Getopt::Std;
getopts('p:n:f:h:b:o:t:');
$pos=$opt_p;
$neg=$opt_n;
$fold=$opt_f;
$tag=$opt_h;
$out=$opt_o;
$blind=$opt_b;
$thresh=$opt_t;
if($pos eq '' ||$out eq '' ||$neg eq ''){print "-p: positive fasta file; 
-n: number of hits to be considered 
-f: folder name in which to run process 
-b: blind data sfasta file
-o: Output file
-t: threshold
-h: tag
example \"perl ~/progs/blastp.pl -p training.fasta -n 1(Number of hits to consider) -f folder_name -o output_file -b blind.fasta\"
training.fasta and blind file must fasta file in following pattern :
>Non-AVP_0136
AENTDANFYVCPPPT
>AVP_0169
CIVEEVDARSVYPYD
";}

else{
system "mkdir $fold";
open(OUT,">$fold/$out");
system "~/progs/fasta2sfasta -i $pos -o $fold/sfasta ;";
open(SFASTA,"$fold/sfasta");
@sfasta=<SFASTA>;
foreach $line (@sfasta){chomp($line);
system "grep -v \'$line\' $fold/sfasta >$fold/DB.sfasta";
#system "cut -d '#' -f1 $fold/DB.sfasta |cut -d '>' -f2 >$fold/tags"
open(TAG_TEM,">$fold/tags");
system "perl -p -e  's/\#\#/\n/g' $fold/DB.sfasta >$fold/DB.fasta";
system "~/blast-2.2.24/bin/formatdb -i $fold/DB.fasta -n $fold/DB -p T";
open(TEMP,">$fold/TEMP");
@split_sf=split("\#\#",$line);
print TEMP $split_sf[0]."\n".$split_sf[1];
$xtag=$split_sf[0];
$xtag=~s/>//g;
print TAG_TEM "$xtag";
close TAG_TEM;
system " ~/blast-2.2.24/bin/blastall -p blastp -d $fold/DB -i $fold/TEMP -F F -f 9 -b $neg -e 100 -m 8 |cut -f1,2,11|sort -u >$fold/$tag\_pos";
open(TAG,"$fold/tags");
open(POS,"$fold/$tag\_pos");
open(NEG,"$fold/$tag\_neg");
undef @pos,undef @neg;
@pos=<POS>;@neg=<NEG>;
close POS;close NEG;
undef @tags;@tags=<TAG>;
foreach $tags(@tags){
print "..";
	chomp($tags);undef @get;undef $un;undef @get;$u=0;
	foreach $un(@pos){chomp($un);if($un=~/^$tags\t.+\t.+/){$get[$u++]=$un."\n";}}
	$size=0;$size=scalar(@get);
	if($size eq 0){print OUT $tags."\tNA\t";print OUT "@get\n";}
	else{undef $add;
	foreach $line(@get){
		chomp($line);
		undef @cut;
		@cut=split("\t",$line);
		$add+=sprintf("%0.20f", $cut[2]);
		}
	print OUT $tags."\t$cut[1]\t";
	printf (OUT "%0.20f\n",$add);
	}
        }
}close OUT;

system "perl ~/progs/blastp2result.pl $fold/$out $thresh |cut -f3 >$fold/RES_Internal";
print "\n####--Results on self $pos dataset--####\n";
system "perl ~/progs/unique_array.pl $fold/RES_Internal";

system "perl ~/progs/blastp.pl_blind1 -p $blind -n 1 -f $fold -o $fold/blind_result -d $pos";
system "perl ~/progs/blastp2result.pl $fold/blind_result $thresh |cut -f3 >$fold/RES_out";
print "\n####--Results on blind $blind dataset--####\n";
system "perl ~/progs/unique_array.pl $fold/RES_out";
sub def(){@var=@_;foreach $var(@var){undef $var;$var="";}}
}
