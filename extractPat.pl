#!/usr/bin/perl

## Program to extract positive and negative patterns from the complete patterns
## Usage: program list_pdb.txt SFASTAsequence_lowerFile positivePatFile negativePatFile

$pdb_list=$ARGV[0]; ## list of PDB ids e.g. 1ACC_A
$seq_file=$ARGV[1]; ## sequence file (small letter) in SFASTA format
$pos=$ARGV[2];
#$neg=$ARGV[3];

open (POS,">$pos");
#open (NEG,">$neg");

open (SEQS,"$seq_file");
@seqs=<SEQS>; close SEQS;

open (LIST,"$pdb_list");
while ($list=<LIST>)
{
chomp $list;

#print POS "#$list\n";
#print NEG "#$list\n";

foreach $seq (@seqs)
 {
chomp $seq;

if ($seq =~ /$list/)
  {
	$seq =~ /(\w+) ##(.+)/;
	$head=$1; $tail=$2;
	@residues=@pos=();
$tail=~tr/SYT/syt/;#for neg pattern phospho
$tail=~s/1/S/g;#for neg pattern phospho
$tail=~s/2/T/g;#for neg pattern phospho
$tail=~s/3/Y/g;#for neg pattern phospho
	@residues=split "",$tail;
	for ($x=0;$x<@residues;$x++)
	{
	 if ($residues[$x] =~ /[a-z]/) 	 { 	 push (@pos,($x+1)); 	 }
	} ## Closing for $x loop
  }
 } ## close foreach $seq loop

#print "$head:$tail:\nPOS:@pos:\n";

open (PAT,"$list.pat");  ## .pat file should contain first header line with ##
@pat=<PAT>; close PAT;

for ($z=1;$z<@pat;$z++)  ## Starting from 1 as first line contains ## Header line
 {
   $count=0;
   foreach $in(@pos) {if ($z == $in){ $count++;	}    }
   if ($count != 0)  {print POS "$pat[$z]";	}
   else 	     {#print NEG "$pat[$z]";	
}
 }

} ## Close LIST loop
close LIST;
close POS;
#close NEG;
