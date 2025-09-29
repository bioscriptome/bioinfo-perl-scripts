		open(ACC,$ARGV[0]);#acc and gene location file # AB042770	7953..8633
open(AF,">$ARGV[0].single_line");#acc and gene location file # AB042770	7953..8633
open(AF,">$ARGV[0].single_line");#fastafile;
while($seq=<ACC>){chomp($seq);
($acc,$pos)=split("\t",$seq);
if($seq=~/(join|complement)/){
($acc,$pos)=split("\t",$seq);
$pos=~s/[A-Za-z\(\)]+//;
$pos=~s/\)+//;
#print $pos;
@pos=split(",",$pos);
#print "@pos";
foreach $pos1(@pos){print AF $acc."\t".$pos1."\n";}

}
else {print AF $acc."\t".$pos."\n";}




}

