

open(FH,$ARGV[0]);
open(FA,">$ARGV[1]");

while($seq=<FH>){
chomp($seq);
@split=split("##",$seq);
print FA $split[0]."\n".$split[1]."\n";

}
