open(FH,$ARGV[0]);
if($ARGV[0] eq ''){print "Usage: perl program.pl  inputfile  numoffolds\n";}
else{
@array=<FH>;
$size=scalar(@array);
$pos_size=` wc -l $ARGV[1] |cut -d ' ' -f1`;
chomp($pos_size);
$div=$pos_size/$size;
print "$pos_size/$size\n";
#print $div;
$div1= sprintf("%d", $div);
print "$pos_size\t$div1";
$str="";
for($i=1;$i<($div1+1);$i++){
$str="";
       for($j=$i;$j<=$pos_size;$j=$j+$div1){
      	$str.=" sed -n -e '$j\p'"; 
       }
$str.=" $ARGV[1]";
print $str,"\n";
system "$str >neg\_$i";
}
}
#print $str;
