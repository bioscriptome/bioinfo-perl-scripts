#!/usr/bin/perl
#program to run svm light automatically with different values of parameters

@g=(0.005);
@c=(0.001, 0.005, 0.01, 0.05, 0.1, 0.5, 1, 5, 10, 50, 100, 200, 400, 600, 800, 1500, 3000, 5000, 7000, 9000);
#@j=(1, 2, 3);

for($i=0;$i<@g;$i++)
{
    for($i1=0;$i1<@c;$i1++)
    {
	#for($i2=0;$i2<@j;$i2++)
	#{

	    open(FP,">>OUT");	 
	    print FP "**************************************\n";   
	    print FP"\ng:$g[$i] c: $c[$i1] j: 1\txxx\t"; 
	    
	    
	    for($s=1;$s<=5;$s++)	    
	    {
		print "Now runnig for model$s at -z c -t 2 -g $g[$i] -c $c[$i1] -j 1 \n";
		system "./svm_learn -z c -t 2 -g $g[$i] -c $c[$i1] -j 1 train_$s model$s";
		
	        system "./svm_classify test_$s model$s results$s ";
                system "cat results$s>>RESULT";
		
		system "cat test_$s>>TESTSET";
	    }
	    system "rm model$s results$s";
	    system "perl roc.pl TESTSET RESULT OUT";
	    print "perl accuracy1.pl TESTSET RESULT  OUT\n";
	    system "perl accuracy1.pl TESTSET RESULT OUT";
	    print "perl accuracy.pl TESTSET RESULT  OUT\n";
	    system "perl accuracy.pl TESTSET RESULT OUT";	    
	    system "rm TESTSET RESULT";
	#}
    }
    
}
system "perl c-analysis.pl OUT";
system "rm result* model*";
