#SEQUENCE NAME                      DESCRIPTION                   E-VALUE  LENGTH
#!/usr/bin/perl
use Getopt::Std;
getopts('p:n:m:e:f:t:');

$pos=$opt_p;
$neg=$opt_n;
$motif=$opt_m;
$eval=$opt_e;
$fold=$opt_f;
$tag=$opt_t;

if($pos eq '' ||$neg eq '' ||$motif eq ''||$eval eq '' ||$fold eq '' ||$tag eq ''){print "-p: positive fasta file; 
-n: negative fasta file
-f: folder name in which to run process 
-y: pos database or engative (p/n)
-d: database folder path\n";}
else{
 system "~/softy/meme/bin/mast $motif $pos -ev $eval -o $fold";
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
print FA "$1\n";
#}
}
$l=$new[$next++];
}
system "perl -p -e 's/\n\n//g' $fold/mast_output  |grep '[^\s]'>$fold/ids";
system "egrep -v -f $fold/ids  $pos |grep '>' >$fold/left_out_$tag ";
}

