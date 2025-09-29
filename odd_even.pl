open(FH,$ARGV[0]);
@array=<FH>;
close FH;
$c=0;
foreach $line(@array){
chomp($line);
$c++;
$mod=$c%2;
#print $mod."!!!!!!!";
if($mod eq 1 ){print $line."\t";}else{print $line."\n";}

}
