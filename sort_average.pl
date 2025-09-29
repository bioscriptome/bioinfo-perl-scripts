#AT G=0.00005 & C=500 average=0.304065764558877
open(FILE,$ARGV[0]);
@array=<FILE>;
close FILE;
foreach $line(@array){
    chomp($line);
    @explode=split("average=",$line);
    $data{$explode[0]}=$explode[1];

}

foreach $r(sort{ $data{$a} <=> $data{$b} } keys %data){
    print "$data{$r}\t$r\n";}
