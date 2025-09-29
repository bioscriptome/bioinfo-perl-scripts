#!/usr/bin/perl

#@cc=qw(0.0001 0.0005 0.001 0.003 0.006 0.01 0.03 0.06 0.1 0.3 0.6 1 2 5);

#@dd=qw(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15); 

#@gg=qw(0.0001 0.0003 0.0006 0.001 0.003 0.006 0.01 0.03 0.06 0.1 0.5 1);

#@gg=qw(0.0001 0.0003 0.0005 0.0006 0.0008 0.001 0.003 0.006);
#@cc=qw(1 2 3 5 10 20 50 100 150 200 500);

#@gg=qw(0.0001 0.0003 0.0005 0.0006 0.0008);
#@cc=qw(300 350 400 450 550 600 700 800 1000);

@gg=qw(0.00001 0.00005 0.00008 0.0001 0.0005 0.001 0.003 0.005 0.006 0.01);
@cc=qw(0.0001 0.0005 0.001 0.005 0.01 0.05 0.1 0.5 1  50 100  500 1000);
# G=0.01 & C=0.9 
#@gg=qw(0.01);
#@cc=qw(0.9);

open(MAJ,">>RESULT");
print MAJ"------G=@gg--------C=@cc-------J=@jj-----------D=@dd-------\n";
close MAJ;
system "perl ~/progs/sipred_progs/mk/actual_data_test.pl $ARGV[1]";
#for($y=0;$y<@cc;$y++){
#for($y1=0;$y1<@dd;$y1++){
for($y2=0;$y2<@gg;$y2++){
for($y3=0;$y3<@cc;$y3++){
#for($y4=0;$y4<@jj;$y4++){

#for($num=1;$num<11;$num++){
	#system "./svm_learn -z r -t 0 -c $cc[$y] train_$num.pat model_$num";
        #system "./svm_learn -z r -t 1 -d $dd[$y1] train_$num.pat model_$num";
        #system "./svm_learn -z r -t 2 -g $gg[$y2] train_$num.pat model_$num";
        #system "./svm_learn -z r -t 2 -c $cc[$y3] train_$num.pat model_$num";
        #system "./svm_learn -z r -t 2 -j $jj[$y4] train_$num.pat model_$num";
        system " ~/progs/sipred_progs/mk/svm_learn -z r -t 2 -g $gg[$y2] -c $cc[$y3] $ARGV[0] train.model";
        #system "./svm_learn -z r -t 2 -g $gg[$y2] -c $cc[$y3] -j $jj[$y4] train_$num.pat model_$num";

	system "~/progs/sipred_progs/mk/svm_classify $ARGV[1] train.model observed";
	
	open(MAT,">>RESULT");
	
        #print MAT"-------linear kernel---c=$cc[$y]--test_$num.pat---------\n";
	#print MAT"-------polynomial kernel---d=$dd[$y1]--test_$num.pat---------\n";
        #print MAT"-------RBF kernel---G=$gg[$y2]----test_$num.pat---------\n";
        #print MAT"-------RBF kernel----C=$cc[$y3]-----test_$num.pat---------\n";
        #print MAT"-------RBF kernel----J=$jj[$y4]-----test_$num.pat---------\n";
        print MAT"-------RBF kernel---G=$gg[$y2]----C=$cc[$y3]---test_$num.pat---------\n";
        #print MAT"-------RBF kernel---G=$gg[$y2]----C=$cc[$y3]-----J=$jj[$y4]------test_$num.pat---------\n";

	system "perl ~/progs/sipred_progs/mk/correl_sirna.pl observed actual_data";
	#system "rm model_* out_*";
	
 #   }
    print MAT"\n\n";
#}
}
}
close MAT;

