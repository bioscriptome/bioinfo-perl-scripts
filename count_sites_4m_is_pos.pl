if($ARGV[0] eq ''){print "Enter id_pos.sfasta file\n";}
open(FO,$ARGV[0]);
@array=<FO>;
close FO;
$tot=0;
foreach $line(@array){
    chomp($line);
($id,$pos)=split("##",$line);
@count=split("\t",$pos);
$size=scalar(@count);
$tot+=$size;
print $id."\t".$size."\n";
}
print $tot."\n";
