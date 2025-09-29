#!/usr/bin/perl


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
@gg=qw(0.001 0.002 0.003 0.005 0.008 0.01 0.02 0.05 0.1 0.2 0.5 1 5 10 20 50 100);
@cc=qw(0.001 0.002 0.005 0.008 0.01 0.02 0.05 0.1 0.2 0.5 1 5 10 20 50 100);
@jj=qw(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15); 

for($y=0;$y<@gg;$y++)
{
    for($y1=0;$y1<@cc;$y1++)
    {
	for($y2=0;$y2<@jj;$y2++)
	{
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
		system "./svm_learn -z c -t 2 -g $gg[$y] -c $cc[$y1] -j $jj[$y2] trainingset model";
		system "./svm_classify testset model result";
		system "cat result >>observed_data";
		system "rm result model trainingset testset";
	    }
	    system "./svmc_accuracy_sirna.pl";
	    system "rm observed_data";
	    exit;
	}
    }
}
