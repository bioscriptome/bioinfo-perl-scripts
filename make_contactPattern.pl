#!/usr/bin/perl

## Progran to make patterns from the sequence file Whereever it finds small letters ; Add X at the start and end of the sequence

# Usage: program inputSFastaFile_lower windowLength PosPatternOutputFile 

open (SEQUENCE,"$ARGV[0]"); ## Sequence input file 'sequence_dssp_lower.txt' having contact positions in small letters (SFASTA format)
@seqs=<SEQUENCE>; close SEQUENCE;

$window=$ARGV[1];   ## Window size to create pattern
chomp $window;

open (OUTPUT, ">$ARGV[2]"); # output file for patterns 'pattern_Poscontact.txt'

$n=int(($window-1)/2);
$add='X' x $n;

foreach (@seqs)
{
chomp $_;
$head=$seq=""; @res=();
$_ =~ />(.+?) ##(.+)/;
$head=$1; $seq=$2;

## Adding 10 (for 21 window) 'X' residues at both the ends of sequence so that we can get all the patterns even central residue at the end of the sequence
chomp($seq);

$seq=($add.$seq.$add);  ## Keep sequence as such normal residues in caps and contact residues in lower case
#print $seq."how r u\n";
#$index=index($seq,'[a-z]');
#print "SEQ:$seq\n";

print OUTPUT ">$head\n";

@res=split"",$seq;

	for ($x=0;$x<@res;$x++)
	{
	$pos=$start=$end=0;$pat="";
	@pat=();
	#print "$res[$x]:";
         if ($res[$x] =~ /[a-z]/)  ## Traping lower case residues ie contact residues only
	  {
	#print "$res[$x]:$x:";
	$pos=$x;
	$start=($pos-$n);  # for making window of 21 and contact residue at the center ! modify this value ('10') accordingly at both places
	$end  =($pos+$n);
        @pat=@res[$start..$end]; # slice function
	$pat=join"",@pat;
	$pat=uc($pat);
	print OUTPUT "$pat\n";
	  }
	}
#exit;
}
close OUTPUT;
