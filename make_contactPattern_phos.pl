#!/usr/bin/perl
#use Multi_index;
## Progran to make patterns from the sequence file Whereever it finds small letters ; Add X at the start and end of the sequence
# Usage: program inputSFastaFile_lower windowLength PosPatternOutputFile 
open (SEQUENCE,"$ARGV[0]"); ## Sequence input file 'sequence_lower.txt' having contact positions in small letters (SFASTA format)
@seqs=<SEQUENCE>; close SEQUENCE;
$window=$ARGV[1];   ## Window size to create pattern
chomp $window;
open (POS, ">$ARGV[2]"); # output file for patterns 'pattern_Poscontact.txt'
open (NEG, ">$ARGV[3]");
$n=int(($window-1)/2);
$near=$ARGV[4];
if($near=~/[\d+]/){$near=$near;}else{$near=9;}
$len_seqs=scalar(@seqs)+1;
$add='X' x $n;$up=0;$down=0;
foreach (@seqs)

	{chomp $_;
	$head=$seq=""; @res=();
	$_ =~ />(.+?)##(.+)/;
	 $head=$1; $seq=$2;chomp($seq);
        $seq=($add.$seq.$add);
	## Adding 10 (for 21 window) 'X' residues at both the ends of sequence so that we can get all the patterns even central residue at the end of the sequence
	chomp($seq);
	 if($seq=~/[st]/){
	     print POS ">$head\n";
	     print NEG ">$head\n";

	@res=split"",$seq;
	$po=0;$neg=0;
		for ($x=0;$x<@res;$x++)
		{
		$pos=$start=$end=0;$pat="";
		@pat=();
		#print "$res[$x]:";


		 if ($res[$x] =~ /[st]/)  ## Traping lower case residues ie contact residues only
		  {

		#print "$res[$x]:$x:";
		$pos=$x;
		$start=($pos-$n);  # for making window of 21 and contact residue at the center ! modify this value ('10') accordingly at both places
		$end  =($pos+$n);
		@pat=@res[$start..$end]; # slice function
		$pat=join"",@pat;
		$pat=uc($pat);
		print POS "$pat\n";
                 $POSIT[$up][$po++]=$start+1;
                 $POS_SEQ[$up][$po-1]=$pat;
		  }
		 if ($res[$x] =~ /[ST]/)  ## Traping lower case residues ie contact residues only
		  {
		#print "$res[$x]:$x:";
		$pos=$x;
		$start=($pos-$n);  # for making window of 21 and contact residue at the center ! modify this value ('10') accordingly at both places
		$end  =($pos+$n);
		@pat=@res[$start..$end]; # slice function
		$pat=join"",@pat;
		$pat=uc($pat);
		print NEG "$pat\n";
		$NEG[$down][$neg++]=$start+1;
                 $NEG_SEQ[$down][$neg-1]=$pat;
		  }
		}
$up++;$down++;
	#exit;
}
}














__END__
foreach (@seqs)
	{chomp $_;
	$head=$seq=""; @res=();
	$_ =~ />(.+?)##(.+)/;
	$head=$1; $seq=$2;}
#system "perl /media/data/progs/";
close POS,NEG;print "\n\n\n\n";

open(NEG_NEAR,">$ARGV[3]_nearest");
for($all=0;$all<$len_seqs;$all++){
	chomp $_;$head=$seq="";@res=();	$seqs[$all] =~ />(.+?)##(.+)/;$head=$1; $seq=$2;	
	$len_2d_n=$#{$NEG[$all]}+1;
	$len_2d_p=$#{$POSIT[$all]}+1;
	#print $len_2d;
        print NEG_NEAR ">$1\n";
	for($m=0;$m<$len_2d_p;$m++){
		for($n=0;$n<$len_2d_n;$n++){
			#print $NEG_SEQ[$all][$n]."\n";
			#print $POSIT[$all][$n]."\t".$NEG[$all][$m]."\n";
				if(($NEG[$all][$n] > ($POSIT[$all][$m]-$near)) && ($NEG[$all][$n] < ($POSIT[$all][$m]+$near))){
					print $NEG[$all][$n]."\t";
					print NEG_NEAR $NEG_SEQ[$all][$n]."\n";
				}
		}
	}
}
