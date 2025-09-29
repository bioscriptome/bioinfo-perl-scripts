open(FH,$ARGV[0]);
@array=<FH>;
$all_seq=join("",@array);

@array_protein=split("####",$all_seq);
foreach $protein(@array_protein){
#
if($protein=~/<site position/){#print $protein."\n";
@array_temp=split("\n",$protein);
foreach $line(@array_temp){
if($line=~/<accession>([A-Za-z0-9]+)<\/accession>/){print "\n".$1."\t";}
if($line=~/<sequence>([A-Za-z]+)<\/sequence>/){print $1."\t";}
if($line=~/<site position="(\d+)">/){print $1."\t";}


}

}

}

