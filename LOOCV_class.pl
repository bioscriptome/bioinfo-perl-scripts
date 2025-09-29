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

open(MAP,">>RESULT");
print MAP"thres\ttp\tfn\tfp\ttn\tcor_coeff\tsen\tspe\tacc\n";
close MAP;

#@gg=qw(0.0001 0.0003 0.0005 0.0008 0.0098 0.001 0.0011 0.0012 0.0013 0.0014 0.0016 0.0018 0.0019 0.002 0.0021 0.0022 0.0025 0.0028 0.003 0.0032 0.0035 0.0038 0.004 0.005);
#@cc=qw(0.3 0.5 1 1.5 2 3 4 5 6 8 10 15 20);
#@jj=qw(0.8 0.9 1 1.1 1.2); 

@gg=qw(0.001 0.0011 0.0012 0.0013 0.0014 0.0025);
@cc=qw(0.3 0.5 2 6 8 10 18 20 25);
@jj=qw(0.8 0.9 1 1.1 1.2); 



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
	    system "./svmc_accuracy02_sirna.pl";
	    system "rm observed_data";
	}
  }
}
