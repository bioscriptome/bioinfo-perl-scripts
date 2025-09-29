#121	S	SSDSNASSSSETS#SCSSSFEDGSVI	-1.55	47.64%
if($ARGV[0] eq ''){print "ARGV[0]=musite_result_file\nARGV[1]=musite2roc_input_file";}
open(FH,$ARGV[0]);
open(FA,">$ARGV[1]");
@array=<FH>;
close FH;
foreach $line(@array){
chomp($line);
if($line=~/^>/){}
elsif($line=~/\d+\s+([sSTt])\s+[A-Za-z\#\*]+\s+([0-9\-\.]+)\s+/){
$s1=$1;
$s2=$2;
if($s1=~/[st]/){print "+1\t".$s2."\n";}
else{print "-1\t".$2."\n";}

}


}
