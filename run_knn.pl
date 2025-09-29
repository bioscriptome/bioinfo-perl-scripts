use Getopt::Std;
getopts('i:o:');

$file1=$opt_i;
$file2=$opt_o;
@algo=qw(0 1 2 3 4);
#@algo=qw(0 1 2 3 4);#0 or IB1   : IB1     (default),
		    #1 or IG    : IGTree
		    #2 or TRIBL : TRIBL
		    #3 or IB2   : IB2
@mat=qw(C D CD L O E M J S N I);
@weigh=qw(0 1 2 3 4 5);
@k=qw(2 3 4 5 6 7 8 9 10 15 20 30 50 100);

if($opt_i eq '')
{
    print "USAGE: apro2aac1.pl -i <i/p file> -o <mode>\n";
    print "-i\tSequence in sFASTA format\n";
    print "-o\tout put file\n";
    exit();
}
else{
for ($g1=0;$g1<@algo;$g1++){
#for ($g1=0;$g1<1;$g1++){
 # for($j1=0;$j1<@mat;$j1++){
       for($c1=0;$c1<@k;$c1++){
            for ($t=1;$t<6;$t++){
               system "timbl -f train_$t.arff -t test_$t.arff -a $algo[$g1] -k $k[$c1]   -o out_res1\_$t";
	       print "timbl -f train_$t.arff -t test_$t.arff -a $g1 -k $c1 -m $j1  -o out_res1\_$t";
		}
	       system "rm train.arff EVAL_RES";
	       system "cat train_1.arff test_1.arff>train.arff";
               system "timbl -f train.arff -t eval_1.arff -a $algo[$g1] -k $k[$c1]   -o EVAL_RES";		
	   
	    system "cat out_res1* >res_a\_$algo[$g1]";
	    open(FH,"res_a_$algo[$g1]");
 	    @res=<FH>;
	    close FH;
	    open(KNN,">>knn_res");
	    $TP=$FP=$FN=$TN=$SN=$SP=$ACC=$MCC=0;
            print KNN "\n\nAt a=$algo[$g1] -k $k[$c1] -m $mat[$j1]\n";
	foreach $line(@res){
	chomp($line);
		if($line=~/,(.{2,3}),(.{2,3})$/){
			print "$1\t$2\n";
			if(($1 eq '+1') &&($2 eq '+1')){$TP++;}
			if(($1 eq '-1') &&($2 eq '+1')){$FP++;}
			if(($1 eq '+1') &&($2 eq '-1')){$FN++;}
			if(($1 eq '-1') &&($2 eq '-1')){$TN++;}
		}
		else{print "wewewe";}
	}
	$mcc=`perl ~/progs/mcc.pl -p $TP -n $TN -f $FP -m $FN`;
	print KNN $mcc;
	open(FH,"EVAL_RES");
	@res=<FH>;
	close FH;
	$TP=$FP=$FN=$TN=$SN=$SP=$ACC=$MCC=0;
	foreach $line(@res){
	chomp($line);
	if($line=~/,(.{2,3}),(.{2,3})$/){
	print "$1\t$2\n";
	if(($1 eq '+1') &&($2 eq '+1')){$TP++;}
	if(($1 eq '-1') &&($2 eq '+1')){$FP++;}
	if(($1 eq '+1') &&($2 eq '-1')){$FN++;}
	if(($1 eq '-1') &&($2 eq '-1')){$TN++;}
	}
	else{print "wewewe";}
}
$mcc=`perl ~/progs/mcc.pl1 -p $TP -n $TN -f $FP -m $FN`;
print KNN "\n".$mcc;
close KNN;
print  "-p $TP -n $TN -f $FP -m $FN\n";

#               system "timbl -f train_$i.arff -t test_$t.arff -a  $g1 -m $j1";
#               system "timbl -f train_$i.arff -t test_$t.arff -a  $g1 -m $j1 -k $c1 -o  out_$t";
		
	  }
  #   }
 }
}
