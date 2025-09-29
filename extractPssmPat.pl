#!/usr/bin/perl 

use Getopt::Std;
getopts('n:s:w:p:a:');

$file_mot=$opt_n;
$file_seq=$opt_s;#file in 2 line sfasta format
$window=$opt_w;
$pdbidList=$opt_p;#list of ids for which you want to extract the pssm
$file_posPat=$opt_a;
#$file_negPat=$opt_b;
print "\t$file_mot\t$file_seq\t$window\t$pdbidList\t$file_posPat\t$file_negPat\t";
#if(open (POSITIVEPAT ,">$file_posPat")){print "POSITIVEPAT opened";}
#if(open (NEGATIVEPAT ,">$file_negPat")){print "negEPAT opened";}
$sum=0;
if(open (TEMPPOS,">temp_pos1")){}
if(open (MOTFILE,"$file_mot")){}else  {print "cud not open\n";}
while ($lineMot=<MOTFILE>)
	{
	$pos == 0;
	chomp $lineMot;
	if ($lineMot =~ />/)
		{
	#	print "LINEMOT:$lineMot\n";
		 $head=""; @posVal=();
		 $lineMot =~ />(.+)?/; $head=$1;
                 chomp($head);
	#	 print "HEAD:$head\n";
		}
	open (SEQFILE,"$file_seq");
	while ($lineSeq=<SEQFILE>)
	  {
	  chomp $lineSeq;
#	  print "LINESEQ:$lineSeq\n";
	 # $lineSeq =~ s/>//g;
	  if ($lineSeq =~ />$head/)
		{
		$seq="";
		$seq=<SEQFILE>; chomp $seq;
$seq=uc $seq; 
	#	print "HEAD:$head:SEQ:$seq\n";
		}
	  }
	close SEQFILE;

$half=int(($window-1)/2);
$addX= 'X' x $half;
$seq=$addX.$seq.$addX;
$pos=index($seq,$lineMot)+1+ $half- $half;

if ($pos != '0')
 {
print TEMPPOS "$head\t$lineMot:$pos\n";

}#else {print "$lineMot $head:$pos\n";}
#exit;
	} ## Close while ($lineMot=<MOTFILE>) loop
close TEMPPOS;
close MOTFILE;

if(open (TEMPLIST,"$pdbidList")){}
@list_pdb=<TEMPLIST>; close TEMPLIST;
if(open (NEW_MOT,">new_motif_file")){}

if(open (TEMPOS2,">temp_pos2")){}
for ($pdb=0;$pdb<@list_pdb;$pdb++)
{
chomp $list_pdb[$pdb];
print NEW_MOT $list_pdb[$pdb]."\n";
print TEMPOS2 "$list_pdb[$pdb]:";
if(open (TEMPPOS,"temp_pos1")){}
while ($tempPos=<TEMPPOS>)
{ 
chomp $tempPos;
$fileHead=$patPos=""; 
#$tempPos =~ /(\w+):(.+)/;$fileHead=$1; $patPos=$2;
$tempPos =~ /(.+?)\t(.+):(.+)/;$fileHead=$1; $patPos=$3;$MOT=$2;
#if ($list_pdb[$pdb] eq $fileHead) { print TEMPOS2 "\t$patPos"; }
if ($list_pdb[$pdb] =~ $fileHead) { print TEMPOS2 "\t$patPos"; $sum++;
				    print NEW_MOT $MOT."\n";
}
 }
close TEMPPOS;
print TEMPOS2 "\n";
}
close TEMPPOS2;

system "perl ~/progs/pssm/make_pat.pl  $file_posPat ";#-b $file_negPat;
#system "perl /home/rahman/PROJECTS/SVMProgs/pssm/make_pat_Nooverlap.pl -a $file_posPat -b $file_negPat";

#system "rm temp_pos1 temp_pos2";

print $sum."\n";
