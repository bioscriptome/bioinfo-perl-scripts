open(FH,$ARGV[0]);
open(FA,">".$ARGV[1]);$i=0;$l1=0;
while($line=<FH>){if($line=~/>/){
    $line=~/>(.+)/;
    $l1++;
print FA "\n>".$1."##";}if($line=~/^(\d+)\t.+/){print FA $1."\t";$i++;}}
print "total number of protein detected to be phosphorylated-----:$l1\n";
print "total number of residues detected to be phosphorylated-----:$i\n";
$out=$ARGV[1].'_Prot-'.$l1.'_Res-'.$i.'.id_pos';
system "mv $ARGV[1] $out";
