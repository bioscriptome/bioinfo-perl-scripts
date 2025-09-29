#!/usr/bin/perl
use lib "/home/nishant/progs/sub";
use SUB;  
#@cc=qw(0.001 0.005 0.01 0.05 0.1 0.5 1 5 10 25 50 75 100 200 400 500 1000);
#@cc=qw( 0.007 0.008 0.009 0.01 0.012 0.014 0.016 0.018 0.02 0.03 0.04 0.06 0.08 0.3 0.7 0 3  );

#@dd=qw(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15); 

#@gg=qw(0.0003 0.0005 0.0007 0.001 0.003 0.005 0.007 0.009 0.03 0.05 0.06 0.07 0.08 0.09 0.1 0.11 0.12 0.13 0.14 0.15 0.16 0.17 0.18 0.19 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1 2 3 4 5  );
#@cc=qw(0.01 0.03 0.06 0.1 0.3 0.7 0 1);

#@gg=qw(0.00005 0.0001 0.0005 0.0008 0.001 0.002 0.003 0.01 0.05 0.1 1 5 10 25 50 75 100 200);
#@cc=qw(0.05 0.1 0.3 0.6 1 3 5);
@gg=qw(0.00005 0.0001 0.0005 0.001 0.005 0.01 0.05 0.1 0.5 1 5 10 50 100 );
@cc=qw( 0.0005 0.001 0.005 0.01 0.05 0.1 0.5 1 5 10 50 100 );
####@gg=qw(0.001 0.002 0.003 0.004 0.005 0.006 0.007 0.008 );
####@cc=qw(0.005 0.009 0.05 0.09 0.5 0.9 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 18 20);

   
#for($y3=0;$y3<@cc;$y3++){

#for($y2=0;$y2<@dd;$y2++){

 for($y1=0;$y1<@gg;$y1++){
for($y=0;$y<@cc;$y++){
@correl=();
$correl="";
    for($num=1;$num<11;$num++){
	#system "~/progs/svm_learn -z r -t 0 -c $cc[$y3] train_$num model_$num";
        #system "../svm_learn -z r -t 1 -d $dd[$y2] train_$num.pat model_$num";
       
	#system "/media/data/progs/svm_learn -z r -t 2 -g $gg[$y1] train_$num model_$num";
     

               #system "../svm_learn -z r -t 2 -c $cc[$y] train_$num model_$num";
           	 system "~/progs/svm_learn -z r -t 2 -g $gg[$y1] -c $cc[$y] train_$num model_$num";


system "~/progs/svm_classify test_$num model_$num out_$num";


	
	open(MAT,">>RESULT");
			 open(MAT1,">result");
	
      #print MAT"-------linear kernel---c=$cc[$y3]--test_$num.pat---------\n";
	#print MAT"-------polynomial kernel---d=$dd[$y2]--test_$num.pat---------\n";
      #print MAT"-------RBF kernel---G=$gg[$y1]----test_$num---------\n";
        #print MAT1"-------RBF kernel---G=$gg[$y1]----test_$num---------\n";
	# print MAT"-------RBF kernel---C=$cc[$y]-----test_$num---------\n";
   print MAT"-------RBF kernel---G=$gg[$y1]----C=$cc[$y]---test_$num.pat---------\n";
#	system "perl /media/data/progs/sipred/correl_sirna.pl out_$num score_$num";
            $out="out_$num";
	    $score="score_$num";
$correl=SUB::correl($out,$score);
print MAT "Correlation=$correl\n";
push(@correl,$correl);
#	system "rm model_* out_*";
	
    }
$avg_cor=0;
foreach $cor(@correl){
    #print MAT"$cor\n";
$avg_cor+=$cor;
}
$avg_fin=$avg_cor/10;
print MAT "\nAVG correl=$avg_fin\n\n"
   
}
}
 close MAT;
