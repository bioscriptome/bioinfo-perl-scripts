if($ARGV[0] eq ''){print "Enter id_pos.sfasta file\n";}
open(FO,$ARGV[0]);
@array=<FO>;
close FO;
$tot=0;
foreach $line(@array){
    chomp($line);
($id,$pos)=split("##",$line);
#@count=split("",$pos);
$cs=($pos=~tr/s//);
$ct=($pos=~tr/t//);
$cy=($pos=~tr/y//);
$ch=($pos=~tr/h//);

$size=$cs+$ct+$ch+$cy;
$tcs+=$cs;
$tct+=$ct;
$tcy+=$cy;
$tch+=$ch;
#$size=scalar(@count);
$tot+=$size;
if($ARGV[1] eq 'y'){print $id."\t".$size."\n";}
}
print "total s sites :$tcs\n";
print "total t sites :$tct\n";
print "total h sites :$tch\n";
print "total y sites :$tcy\n";

print "total st sites :$tot\n";
