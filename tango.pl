open(FH,$ARGV[0]);
@array=<FH>;
close FH;
foreach $line(@array){
chomp($line);
@split=split("##",$line);
$split[0]=~s/>//g;
$ret=`~/softy/tango_x86_64_release tango $split[0] nt="N" ct="N" ph="7.4" te="303" io="0.05" tf="0" stab=”-10” seq="$split[1]"`;
if($ret=~/AGG ([\d\.\-e]+) AMYLO ([\d\.\-e]+) TURN ([\d\.\-e]+) HELIX ([\d\.\-e]+) HELAGG ([\d\.\-e]+) BETA ([\d\.\-e]+)/){
print $split[0]."\t$ARGV[1] 1:$3 2:$4 3:$6\n";
#print $split[0]."\t$1\t$2\t$3\t$4\t$5\t$5\t$6\n";
}
else{print $ret."\n";}
}
