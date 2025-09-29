#!/usr/bin/perl

system "rm RESULT actual_data observed_data testset trainingset";
$file1=$ARGV[0];
open(IN,"$file1");
while($line=<IN>)
{
    chomp($line);
    $aa[$i]=$line;
    $i++;
}
close IN;
system "cut -f1 -d ' ' $file1>>actual_data";


#@gg=qw(0.000001 0.000005 0.000008 0.000009 0.0000095 0.0000098 0.00001 0.000012 0.000015 0.00002);
#@@cc=qw(5000 2000 1500 1200 1100 1050 1000 950 900 800);
#@jj=qw(0.8 0.9 1 1.1 1.2 2 3 5); 

#@gg=qw(0.00001 0.00003 0.00005 0.00008 0.0001 0.0003 0.0005 0.0008 0.001 0.003 0.005 0.008 0.01 0.05);
#@cc=qw(1000 700 500 200 100 50 20 10 5 1 0.5 0.1);
#@jj=qw(0.8 0.9 1 1.1 1.2); 

#@gg=qw(0.0001 0.0005 0.001 0.005 0.01 0.05 0.1 0.5 1 5 10 50 100 500 1000);
#@cc=qw(100 50 10 1 0.5 0.1 0.01 0.001 0.0001);
#@jj=qw(0.8 0.9 1 1.1 1.2); 

#@gg=qw(0.0001 0.001);
#@cc=qw(1);
#@jj=qw(0.8 0.9 1 1.1 1.2); 

@gg=qw(0.0001 0.0002 0.0003 0.0005);
@cc=qw(10 1 20 50);
@jj=qw(1); 



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
 
    for($c=0;$c<@aa;$c++)
    {
	for($k=0;$k<@aa;$k++)
	{
	    if($c==$k)
	    {
		open(OUT,">testset");
		print OUT"$aa[$k]\n";
		close OUT;
	    }
	    else
	    {
		open(OUT,">>trainingset");
		print OUT"$aa[$k]\n";
		close OUT;
	    }
	}
	#system "./svm_learn -z r -t 0 -c $cc[$y] trainingset model";
	#system "./svm_learn -z r -t 1 -d $dd[$y1] trainingset model";
	#system "./svm_learn -z r -t 2 -g $gg[$y2] trainingset model";
        #system "./svm_learn -z r -t 2 -c $cc[$y3] trainingset model";
	#system "./svm_learn -z r -t 2 -j $jj[$y4] trainingset model";
        #system "./svm_learn -z r -t 2 -g $gg[$y2] -c $cc[$y3] trainingset model";
        system "./svm_learn -z r -t 2 -g $gg[$y2] -c $cc[$y3] -j $jj[$y4] trainingset model";
	
	system "./svm_classify testset model out";
	system "cat out>>observed_data";
	system "rm trainingset testset model out";	
	
    }
    open(MAJ,">>RESULT");
    #print MAJ"-------linear kernel-------c=$cc[$y]-----------\n";
    #print MAJ"-------polynomial kernel---d=$dd[$y1]-----------\n";
    #print MAJ"-------RBF kernel----------G=$gg[$y2]-----------\n";
    #print MAJ"-------RBF kernel----------C=$cc[$y3]------------\n";
    #print MAJ"-------RBF kernel----------J=$jj[$y4]-----------\n";
    #print MAJ"-------RBF kernel---G=$gg[$y2]---C=$cc[$y3]------\n";
    print MAJ"-------RBF kernel---G=$gg[$y2]---C=$cc[$y3]---J=$jj[$y4]----\n";
    
    close MAJ;
    system "./correl_sirna.pl observed_data actual_data";
    system "rm observed_data";
}
}
}
