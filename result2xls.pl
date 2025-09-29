
open(FH,$ARGV[0]);
if($ARGV[0] eq ''){
print "ARGV[0] =list of folder from where to collect svm result\n";

}

$fold=$ARGV[0];
$id=`ls $fold`;
@array=split("\n",$id);
#@array=<FH>;
foreach $line(@array){
#svm_result_AURR980103
@split=split("_",$line);
open(FH2,"$fold/$line");
@res=<FH2>;
close FH2;
foreach $name(@res){
print "$split[2]\t$name";

}
}





