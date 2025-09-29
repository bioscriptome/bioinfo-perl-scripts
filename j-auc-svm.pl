#!/usr/bin/perl
#program to run svm light automatically with different values of parameters

@g=(0.005);
@c=(5);
@j=(1, 2, 3, 5);

for($i=0;$i<@g;$i++)
{
    for($i1=0;$i1<@c;$i1++)
    {
	for($i2=0;$i2<@j;$i2++)
	{

	    open(FP,">>OUT");	 
	    print FP "**************************************\n";   
	    print FP"\ng:$g[$i] c:$c[$i1] j:$j[$i2]\t"; 
	    
   
	    for($s=1;$s<=5;$s++)	    
	    {
		print "Now runnig for model$s at -z c -t 2 -g $g[$i] -c $c[$i1] -j $j[$i2]\n";
		system "./svm_learn -z c -t 2 -g $g[$i] -c $c[$i1] -j $j[$i2] train_$s model$s";
		
	        system "./svm_classify test_$s model$s results$s ";
                system "cat results$s>>RESULT$g[$i]\_$c[$i1]\_$j[$i2]";
		
		system "cat test_$s>>TESTSET$g[$i]\_$c[$i1]\_$j[$i2]";
	    }
	    system "rm model$s results$s";
	    system "perl roc.pl TESTSET$g[$i]\_$c[$i1]\_$j[$i2] RESULT$g[$i]\_$c[$i1]\_$j[$i2] OUT";
	    print "perl accuracy1.pl TESTSET$g[$i]\_$c[$i1]\_$j[$i2] RESULT$g[$i]\_$c[$i1]\_$j[$i2]  OUT\n";
	    system "perl accuracy1.pl TESTSET$g[$i]\_$c[$i1]\_$j[$i2] RESULT$g[$i]\_$c[$i1]\_$j[$i2] OUT";
	    print "perl accuracy.pl TESTSET$g[$i]\_$c[$i1]\_$j[$i2] RESULT$g[$i]\_$c[$i1]\_$j[$i2]  OUT\n";
	    system "perl accuracy.pl TESTSET$g[$i]\_$c[$i1]\_$j[$i2] RESULT$g[$i]\_$c[$i1]\_$j[$i2] OUT";	    
	    #system "rm TESTSET$g[$i]\_$c[$i1]\_$j[$i2] RESULT$g[$i]\_$c[$i1]\_$j[$i2]";
	}
    }
    
}
#system "perl analysis.pl OUT";
system "rm result* model*";
