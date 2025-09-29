#!/usr/bin/perl
$fold=$ARGV[0];
open(FO,"$fold/mast.txt");
open(FA,">$fold/mast_output");
@array=<FO>;close FO;$a=0;
foreach $line(@array){
  chomp($line);	$a++;
  if($line=~/SEQUENCE NAME                      DESCRIPTION                   E-VALUE  LENGTH/){$start=$a;}
}
$len=scalar(@array);
@new=@array[$start..$len];
$l=$new[0];
$next=0;
while($l=~/[^\s]/){#print $new[$next]."\n";
if($new[$next]=~/--/){}
else{$new[$next]=~/([A-Za-z\_\-\|0-9]+)\s+([a-z\-0-9.]+)\s+(\d+)/;
#print FA "$1\t$2\t$3\n";
$m1=$1;
#if($m1=~/[0-9A-Za-z]/){
print FA "$1\t$2\t$3\n";
#}
}
$l=$new[$next++];
}
