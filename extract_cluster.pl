open(FH,$ARGV[0]);#cluster file
    open(OUT,">".$ARGV[1]);#single cluster out file 
    while($seq=<FH>){
chomp($seq);
@array=split(" ",$seq);
$random_number= int (rand(scalar(@array)));
print OUT $array[$random_number]."\n";

}
