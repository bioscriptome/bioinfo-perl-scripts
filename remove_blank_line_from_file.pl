open(FH,$ARGV[0]);
open(FA,">".$ARGV[1]);
@array=<FH>;
foreach $line(@array){
   if($line=~/^[A-Za-z0-9>]/){print FA $line;}
else{}

}

