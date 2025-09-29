
#!/usr/bin/perl

#@cc=qw(0.0001 0.0005 0.001 0.003 0.006 0.01 0.03 0.06 0.1 0.3 0.6 1 2 5);

#@dd=qw(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15); 
open(EVAL,">RESULT_EVAL");

@gg=qw(0.0001 0.0005 0.001 0.005 0.01 0.05 0.1 0.5 1 10 100 500 1000);                                                                   
@cc=qw(0.0005 0.001 0.005 0.01 0.05 0.1 0.5 1 10 );                                                                   

#wider
#@cc=qw(0.0001 0.0005 0.001 0.005 0.01 0.05 0.1 0.5 1 10 100 1000 10000);
#@gg=qw(0.0001 0.0005 0.001 0.005 0.01 0.05 0.1 0.5 1 10 100 500 1000);                                                                                    
#G=0.5 & C=0.5
#@gg=qw(0.000010.0001 0.0005 0.001 0.005 0.01 0.05 0.1 0.5 0 1 5 10 100);
#@cc=qw(0.01 0.05 0.1 0.3 0.5 0.7 0 1 5 10 20 50 100 500 1000);
#@cc=qw(0.01 0.05 0.1 0.3 0.5 0.7 0 1 5 );
# G=0.1 & C=0.1

#0.01 & C=0.3

#G=0.0005 & C=0.5 
#@gg=qw( 0.01 0.03 );
#@cc=qw( 0.1 1 1.5 );
#G=0.005 & C=0.5   G=0.005 & C=0.1
#G=0.01 & C=1.5
#@gg=qw( 0.01);
#@cc=qw( 1.5 );
#@W=qw(10 1 0.8 0.5 0.1 0.05 0.08 0.01 0.005 0.001 0.0001 0.00001);
#@gg=qw(0);
#@cc=qw(0);
#@W=qw(0.0091);                                                                                                          

open(MAJ,">>RESULT");
print MAJ"------G=@gg--------C=@cc-------J=@jj-----------D=@dd-------\n";
#close MAJ;
   
#for($y=0;$y<@cc;$y++){
#for($y1=0;$y1<@dd;$y1++){
for($y2=0;$y2<@gg;$y2++){
for($y3=0;$y3<@cc;$y3++){
#for($w=0;$w<@W;$w++){

for($num=1;$num<11;$num++){
	#system "./svm_learn -z r -t 0 -c $cc[$y] train_$num.pat model_$num";
        #system "./svm_learn -z r -t 1 -d $dd[$y1] train_$num.pat model_$num";
        #system "./svm_learn -z r -t 2 -g $gg[$y2] train_$num.pat model_$num";
        #system "./svm_learn -z r -t 2 -c $cc[$y3] train_$num.pat model_$num";
        #system "./svm_learn -z r -t 2 -j $jj[$y4] train_$num.pat model_$num";
        print "\n\nRunning at G=$gg[$y2]----C=$cc[$y3]  -w $W[$w]\n";
#       system " ~/progs/sipred_progs/mk/svm_learn -z r -w $W[$w] -t 2 -g $gg[$y2] -c $cc[$y3] train_$num.pat model_$num";
        system " ~/progs/sipred_progs/mk/svm_learn -z r -t 2 -g $gg[$y2] -c $cc[$y3] train_$num.pat model_$num";

        #system "./svm_learn -z r -t 2 -g $gg[$y2] -c $cc[$y3] -j $jj[$y4] train_$num.pat model_$num";

	system "~/progs/sipred_progs/mk/svm_classify test_$num.pat model_$num out_$num";
	
#	open(MAT,">>RESULT");
	
        #print MAT"-------linear kernel---c=$cc[$y]--test_$num.pat---------\n";
	#print MAT"-------polynomial kernel---d=$dd[$y1]--test_$num.pat---------\n";
        #print MAT"-------RBF kernel---G=$gg[$y2]----test_$num.pat---------\n";
        #print MAT"-------RBF kernel----C=$cc[$y3]-----test_$num.pat---------\n";
        #print MAT"-------RBF kernel----J=$jj[$y4]-----test_$num.pat---------\n";
        print MAJ "-------RBF kernel---G=$gg[$y2]----C=$cc[$y3]---test_$num.pat---------\n";
        #print MAT"-------RBF kernel---G=$gg[$y2]----C=$cc[$y3]-----J=$jj[$y4]------test_$num.pat---------\n";
        system "cut -d ' ' -f1 test_$num.pat>score_$num";
	system "perl ~/progs/sipred_progs/mk/correl_sirna.pl out_$num score_$num";
	#system "rm model_* out_*";
	
    }
    print "\n\nRunning eval at G=$gg[$y2]----C=$cc[$y3]  -w $W[$w]\n";
    system "cat train_1.pat test_1.pat>cat_data";
    system "cut -d ' ' -f1 eval_1>score_cat";
    system " ~/progs/sipred_progs/mk/svm_learn -z r -t 2 -g $gg[$y2] -c $cc[$y3] cat_data model_$gg[$y2]_$cc[$y3]";
    system "~/progs/sipred_progs/mk/svm_classify eval_1 model_$gg[$y2]_$cc[$y3] out_cat_data";
    print EVAL "Eval set RBF	G=$gg[$y2]	C=$cc[$y3]	";
    $get=`perl ~/progs/sipred_progs/mk/correl_sirna.pl_1 out_cat_data score_cat`;
    print $get;
    chomp($get);
    print EVAL $get."\n";
    print MAJ "\n\n";
#}
}
}
close MAT;

