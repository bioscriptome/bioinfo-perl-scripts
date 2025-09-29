#!/usr/bin/perl

@g=(0.00001, 0.00005, 0.0001, 0.0005, 0.001, 0.005, 0.01, 0.05, 0.1, 0.5, 1, 5, 10, 15, 20, 25, 30, 40, 50);
@c=(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
@j=(1, 2, 3, 4, 5);

@t=(2, 1); # choose kernel
for($p1=0;$p1<=$#t;$p1++)
{
    if($t[$p1]==2)
    {
	for($i=0;$i<=$#g;$i++){
	    for($i2=0;$i2<=$#c;$i2++){
		for($i11=0;$i11<=$#j;$i11++){
		
		    open(FP3,">>Result");	    
		    print FP3"\n t:$t[$p1]  g:$g[$i]  c:$c[$i2] j:$j[$i11]\n"; 
		    print FP3 "**************************************\n";
		    close FP3;
		    print "Now it's running at -t $t[$p1] -g $g[$i] -c $c[$i2] -j $j[$i11]\n";
		    for($s=1;$s<=5;$s++){
			system "/home/qureshisaab/svm_learn -z r -t $t[$p1] -g $g[$i] -c $c[$i2] -j $j[$i11] train$s.dat model$s";
		#	system "svm_learn -z r -t $t[$p1] -g $g[$i] train$s.dat model$s";
			system "/home/qureshisaab/svm_classify test$s.dat model$s result$s";
			system "cat result$s >>PREDICTED";  
			system "rm model$s result$s";
			system "cat test$s.dat >>TESTSET";
		    }
		    system "cut -d ' ' -f 1 TESTSET > REAL";
		    system "paste REAL PREDICTED >col_file";
		    system "perl col_rsqure.pl -i col_file -a 1 -b 2 >>Result";
		    system "rm PREDICTED TESTSET REAL col_file";
		}
		
	    }
	}
    }
    if($t[$p1]==1) 
    {
	@d1=(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
	@c1=(0.09, 0.05, 0.9, 0.5, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
	@j1=(1, 2, 3, 4, 5);
		
	for($m1=0;$m1<=$#d1;$m1++)
	{
	    for($m3=0;$m3<=$#c1;$m3++){
		for($m2=0;$m2<=$#j1;$m2++){
		    
		    open(FP3,">>Result");	    
		    print FP3"\n t:$t[$p1]  d:$d1[$m1]  c:$c1[$m3] j:$j1[$m2]\n"; 
		    print FP3 "**************************************\n";
		    close FP3;
		    print "Now it's running at -t $t[$p1] d:$d1[$m1]  c:$c1[$m3] j:$j1[$m2]\n";
		    for($s=1;$s<=5;$s++){
			system "/home/qureshisaab/svm_learn -z r -t $t[$p1] -d $d1[$m1] -c $c1[$m3] -j $j1[$m2] train$s.dat model$s";
		#	system "svm_learn -z r -t $t[$p1] -d $d1[$m1] train$s.dat model$s";
			system "/home/qureshisaab/svm_classify test$s.dat model$s result$s";
			system "cat result$s >>PREDICTED";  
			system "rm model$s result$s";
			system "cat test$s.dat >>TESTSET";
		    }
		    system "cut -d ' ' -f 1 TESTSET > REAL";
		    system "paste REAL PREDICTED >col_file";
		    system "perl col_rsqure.pl -i col_file -a 1 -b 2 >>Result";
		    system "rm PREDICTED TESTSET REAL col_file";
		}
		
	    }
	} 
    }
	
}  

