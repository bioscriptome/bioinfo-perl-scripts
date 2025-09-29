open(FH,$ARGV[0]);
@array=<FH>;
$sets=$ARGV[1];
chomp($ARGV[0]);
$pos_size=` wc -l $ARGV[0] |cut -d ' ' -f1`;
for($i=1;$i<($sets+1);$i++){
$str="";
       for($j=$i;$j<=$pos_size;$j=$j+$sets){
      	$str.=" sed -n -e '$j\p'"; 
       }
$str.=" $ARGV[0]";
print $str,"\n";
system "$str >set\_$i";
}
for($i=1;$i<($sets+1);$i++){
system "ls set_* |grep -v set_$i|xargs cat >train_$i";
system "cp set_$i test_$i";

}
#print $str;
