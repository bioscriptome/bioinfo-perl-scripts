#!/usr/bin/perl

#@cc=qw(0.0001 0.0002 0.0003 0.0004 0.0005 0.0007 0.0008 0.0009 0.0098 0.001 0.0011 0.0012 0.0013 0.0014 0.0016 0.0018 0.0019 0.002 0.0021 0.0022 0.0025 0.0028 0.003 0.0032 0.0035 0.0038 0.004 0.005 0.008 0.009 0.01 0.011 0.012 0.015 0.18 0.02 0.03 0.04 0.05 0.08);

#@cc=qw(0.008 0.009 0.0092 0.0094 0.0096 0.0098 0.0099 0.01 0.011 0.012 0.013 0.014 0.015 0.016 0.017 0.18 0.019 0.02 0.022 0.025 0.028 0.03 0.035 0.04 0.045 0.05 0.06 0.07 0.08 0.09 0.1);

#@dd=qw(1 1.5 2 2.5 3 3.2 3.4 3.5 3.6 3.7 3.8 3.9 4 4.1 4.2 4.3 4.4 4.5 4.6 4.7 4.8 4.9 5 5.1 5.2 5.5);  

#@cc=qw(0.00001 0.00005 0.0001 0.0003 0.0005 0.0008 0.001 0.0015 0.002 0.0025 0.003 0.0035 0.004 0.005 0.008 0.008 0.009 0.01 0.015 0.02 0.025 0.03 0.035 0.04 0.045 0.05 0.06 0.07 0.08 0.09 0.1 0.5 1 5 10 20 50 75 100 200);

#@jj=qw(0.8 0.9 1 1.1 1.2 2 3 4 5 6 7 8 9 10); 


#@gg=qw(0.0001 0.0003 0.0005 0.0008 0.0098 0.001 0.0011 0.0012 0.0013 0.0014 0.0016 0.0018 0.0019 0.002 0.0021 0.0022 0.0025 0.0028 0.003 0.0032 0.0035 0.0038 0.004 0.005 0.008 0.01 0.011 0.012 0.013 0.014 0.015 0.016 0.017 0.18 0.019 0.02 0.022 0.025 0.028 0.03 0.035 0.04 0.045 0.05 0.06 0.07 0.08 0.09 0.1 0.5 1 5 10 20 50);
#@cc=qw(0.3 0.5 1 1.5 2 3 4 5 6 8 10 15 20 25 50);
#@jj=qw(0.8 0.9 1 1.1 1.2); 

@gg=qw(0.0001 0.001);
@cc=qw(1);
@jj=qw(0.8 0.9 1 1.1 1.2); 

open(MAJ,">>RESULT");
print MAJ"G=@gg\n";
print MAJ"C=@cc\n";
print MAJ"J=@jj\n\n";
close MAJ;
   
#for($y=0;$y<@cc;$y++){
#for($y1=0;$y1<@dd;$y1++){
for($y2=0;$y2<@gg;$y2++){
for($y3=0;$y3<@cc;$y3++){
for($y4=0;$y4<@jj;$y4++){

for($num=1;$num<6;$num++){
	#system "./svm_learn -z r -t 0 -c $cc[$y] train_$num.pat model_$num";
        #system "./svm_learn -z r -t 1 -d $dd[$y1] train_$num.pat model_$num";
        #system "./svm_learn -z r -t 2 -g $gg[$y2] train_$num.pat model_$num";
        #system "./svm_learn -z r -t 2 -c $cc[$y3] train_$num.pat model_$num";
        #system "./svm_learn -z r -t 2 -j $jj[$y4] train_$num.pat model_$num";
        #system "./svm_learn -z r -t 2 -g $gg[$y2] -c $cc[$y3] train_$num.pat model_$num";
        system "./svm_learn -z r -t 2 -g $gg[$y2] -c $cc[$y3] -j $jj[$y4] train_$num.pat model_$num";

	system "./svm_classify test_$num.pat model_$num out_$num";
	
	open(MAT,">>RESULT");
	
        #print MAT"-------linear kernel---c=$cc[$y]--test_$num.pat---------\n";
	#print MAT"-------polynomial kernel---d=$dd[$y1]--test_$num.pat---------\n";
        #print MAT"-------RBF kernel---G=$gg[$y2]----test_$num.pat---------\n";
        #print MAT"-------RBF kernel----C=$cc[$y3]-----test_$num.pat---------\n";
        #print MAT"-------RBF kernel----J=$jj[$y4]-----test_$num.pat---------\n";
        #print MAT"-------RBF kernel---G=$gg[$y2]----C=$cc[$y3]---test_$num.pat---------\n";
        print MAT"-------RBF kernel---G=$gg[$y2]----C=$cc[$y3]-----J=$jj[$y4]------test_$num.pat---------\n";

	system "./correl_sirna.pl out_$num score_$num";
	system "rm model_* out_*";
	
    }
    print MAT"\n\n";
}
}
}
close MAT;

