open(FH,$ARGV[0]);
open(FH1,$ARGV[1]);
@array=<FH>;
@array1=<FH1>;

foreach $line(@array){
        chomp($line);
        @split=split("\t",$line);        
        foreach $line2(@array1){
        chomp($line2);
        @split2=split("@",$line2);
       # print "$split2[1] eq $split[9]";
        if($split2[3] eq $split[12]){print $line."\t$split2[1]\t$split2[2]\n";}                
        }

}
