#!/usr/perl/bin -w
if($ARGV[0] eq ''){print '#seprating sequences acc to the length of sirna sequence
#usage perl prog.pl file_eff_seq.txt output_file_name'."\n";}
    else{
open(FH,$ARGV[0]);
@eff_seq=<FH>;
close FH;
$i=0;
foreach $eff_seq(@eff_seq){
#		chomp($eff_seq);
		($eff,$seq)=split(" ",$eff_seq);
		$dif_len[$i++]=length($seq);
}
my %seen =() ;
@unique_len = grep { ! $seen{$_}++ } @dif_len;
@sort=sort { $a <=> $b } @unique_len;
print "\n";
print "@sort";

foreach $Sort(@sort){chomp($Sort);
	open(FH,">$ARGV[0]_".$Sort);
		foreach $file(@eff_seq)
		{
			      ($eff1,$seq1)=split(" ",$file);
				$len=length($seq1);
				if($Sort eq $len){print FH  $file;}
		}
close FH;
	}

}
