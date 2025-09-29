#!/usr/bin/perl

system "rm actual_data observed_data testset trainingset";
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


#@gg=qw(0.00001 0.00005 0.00008 0.0001 0.0003 0.0005 0.0008 0.001 0.0012 0.0016 0.002 0.003 0.004 0.005);
#@cc=qw(0.5 1 5 10 15 20 25 30 40 50 60 80 100 150 200 300 500 700 1000);
#@jj=qw(0.8 0.9 1 1.1 1.2); 

open(MAP,">>RESULT");
print MAP"G=@gg\n";
print MAP"C=@cc\n";
print MAP"J=@jj\n\n";
print MAP"thres\ttp\tfn\tfp\ttn\tcor_coeff\tsen\tspe\tacc\n";
close MAP;


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
		
	#system "./svm_learn -z c -t 0 -c $cc[$y] trainingset model";
        #system "./svm_learn -z c -t 1 -d $dd[$y1] trainingset model";
        #system "./svm_learn -z c -t 2 -g $gg[$y2] trainingset model";
        #system "./svm_learn -z c -t 2 -c $cc[$y3] trainingset model";
	#system "./svm_learn -z c -t 2 -j $jj[$y4] trainingset model";
        #system "./svm_learn -z c -t 2 -g $gg[$y2] -c $cc[$y3] trainingset model";
        system "./svm_learn -z c -t 2 -g $gg[$y2] -c $cc[$y3] -j $jj[$y4] trainingset model";

		
		system "./svm_classify testset model out";
		system "cat out >>observed_data";
		system "rm out model trainingset testset";
	    }
	    open(MAJ,">>RESULT");
	#print MAJ"-------linear kernel----------------c=$cc[$y]---------\n";
	#print MAJ"-------polynomial kernel------------d=$dd[$y1]--------\n";
        #print MAJ"-------RBF kernel-------------------G=$gg[$y2]--------\n";
        #print MAJ"-------RBF kernel-------------------C=$cc[$y3]--------\n";
	#print MAJ"-------RBF kernel-------------------J=$jj[$y4]--------\n";
        #print MAJ"-------RBF kernel-----G=$gg[$y2]-----C=$cc[$y3]--------\n";
        print MAJ"-------RBF kernel-----G=$gg[$y2]-----C=$cc[$y3]-----J=$jj[$y4]-----\n";

	    close MAJ;
	    system "./svmc_accuracy_sirna.pl";
	    system "rm observed_data";
	}
  }
}
