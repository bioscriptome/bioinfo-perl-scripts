#!/usr/bin/perl
#program to run svm light automatically with different values of parameters
$win=$ARGV[0];
@g=(0.000004, 0.000008, 0.00001, 0.00002, 0.00003, 0.00004, 0.00005, 0.0001, 0.0005, 0.001, 0.005, 0.01, 0.05, 0.1, 0.5, 1, 5, 10);
#@c=(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15);
#@j=(1, 2, 3, 4, 5);

for($i=0;$i<@g;$i++)
{
    #for($i1=0;$i1<@c;$i1++)
    #{
	#for($i2=0;$i2<@j;$i2++)
	#{

	    open(FP,">>OUT");	    
	    print FP"\n win=$win g:$g[$i] c:$c[$i1] j:$j[$i2]\n"; 
	    print FP "**************************************\n";
	    
	    for($s=1;$s<=5;$s++)	    
	    {
		print "Now runnig for model$s at -z c -t 2 -g $g[$i] -c -j  \n";
		system "./svm_learn -z c -t 2 -g $g[$i] -c -j  train_$s model$s";
		
	        system "./svm_classify test_$s model$s results$s ";
                system "cat results$s>>RESULT";
		
		system "cat test_$s>>TESTSET";
	    }
	    system "rm model$s results$s";
	    
	    print "perl accuracy1.pl TESTSET RESULT  OUT\n";
	    system "perl accuracy1.pl TESTSET RESULT OUT";
	    print "perl accuracy.pl TESTSET RESULT  OUT\n";
	    system "perl accuracy.pl TESTSET RESULT OUT";	    
	    system "rm TESTSET RESULT";
	#}
   # }
    
}
#system "perl svmanalysis-count.pl OUT";
