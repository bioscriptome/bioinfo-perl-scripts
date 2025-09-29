open(FH,$ARGV[1]);#acc number and start_end_position file
open(FH1,$ARGV[0]);#fasta file
@acc_pos=<FH>;close FH;
$com_line='';
while($line=<FH1>){chomp($line);
	if($line=~/>/){$com_line.=$line.'##';}
	else{$com_line.=$line;}

}
#rint $com_line;
$com_line=~s/>/\n>/g;
#print $com_line;
@array=split("\n",$com_line);
foreach $array(@array){chomp($array);
#print $array;
foreach $acc_pos(@acc_pos){
($acc,$pos)=split("\t",$acc_pos);

if($array=~/$acc/){
@split=split("##",$array);
print $split[0]."\n";
$pos=~s/\.\./##/g;
@ar=split('##',$pos);
$st=$ar[0];$end=$ar[1]-$st;
#print  $ar[0]."\t".$ar[1]."\n";
chomp($split[1]);
$sub=substr($split[1],$st,$end);
print ":$pos:$sub."\n";


}
}


}
