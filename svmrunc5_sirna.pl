#!/usr/bin/perl

open(MAP,">>RESULT");
print MAP"thres\ttp\tfn\tfp\ttn\tcor_coeff\tsen\tspe\tacc\n";
close MAP;

@cc=qw(0.0001 0.0005 0.001 0.002 0.003 0.004 0.005 0.006 0.007 0.008 0.009 0.01 0.02 0.05 0.1 0.2 0.5 1 5 10 20 50 100 200 500);

#@dd=qw(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15); 

#@gg=qw(0.001 0.002 0.003 0.005 0.008 0.01 0.02 0.05 0.1 0.2 0.5 1 5 10 20 50 100);
#@cc=qw(0.001 0.002 0.005 0.008 0.01 0.02 0.05 0.1 0.2 0.5 1 5 10 20 50 100);
#@jj=qw(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15); 

#@gg=qw(0.0001 0.0002 0.0005 0.0008 0.0009 0.00095 0.0098 0.001 0.0012 0.0015 0.0018 0.002 0.0025 0.003 0.0035 0.004 0.0045 0.006);
#@cc=qw(0.3 0.4 0.5 0.8 1 3 5 6 8 10 12 15 20 22 25 50 100 200);


for($y=0;$y<@cc;$y++){
#for($y1=0;$y1<@dd;$y1++){
#for($y2=0;$y2<@gg;$y2++){
#for($y3=0;$y3<@cc;$y3++){
#for($y4=0;$y4<@jj;$y4++){

    for($num=1;$num<6;$num++)
    {	
	system "./svm_learn -z c -t 0 -c $cc[$y] train_$num.pat model_$num";
        #system "./svm_learn -z c -t 1 -d $dd[$y1] train_$num.pat model_$num";
        #system "./svm_learn -z c -t 2 -g $gg[$y2] train_$num.pat model_$num";
        #system "./svm_learn -z c -t 2 -c $cc[$y3] train_$num.pat model_$num";
	#system "./svm_learn -z c -t 2 -j $jj[$y4] train_$num.pat model_$num";
        #system "./svm_learn -z c -t 2 -g $gg[$y2] -c $cc[$y3] train_$num.pat model_$num";
        #system "./svm_learn -z c -t 2 -g $gg[$y2] -c $cc[$y3] -j $jj[$y4] train_$num.pat model_$num";
	system "./svm_classify test_$num.pat model_$num out_$num";
	system "cat out_$num >> observed_data";
	system "rm model_$num out_$num";
    }
	open(MAJ,">>RESULT");
	print MAJ"-------linear kernel----------------c=$cc[$y]---------\n";
	#print MAJ"-------polynomial kernel------------d=$dd[$y1]--------\n";
        #print MAJ"-------RBF kernel-------------------G=$gg[$y2]--------\n";
        #print MAJ"-------RBF kernel-------------------C=$cc[$y3]--------\n";
	#print MAJ"-------RBF kernel-------------------J=$jj[$y4]--------\n";
        #print MAJ"-------RBF kernel-----G=$gg[$y2]-----C=$cc[$y3]--------\n";
        #print MAJ"-------RBF kernel-----G=$gg[$y2]-----C=$cc[$y3]-----J=$jj[$y4]-----\n";
        close MAJ;
    
    system "./svmc_accuracy_sirna.pl";
    ###system "rm observed_data";	
}
#}
#}
