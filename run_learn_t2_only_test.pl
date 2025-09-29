

#!/usr/bin/perl
$kernel=$ARGV[0]; # Enter Kernel value ie '0' for Linear, '1' for Polynomial and '2' for Radial
$range_c=$ARGV[1];# Enter values of c/d/ parameter separated with comma
$range_g=$ARGV[2];# Enter values of g parameter separated with comma incase of radial kernel
$range_j=$ARGV[3];# Enter values of j parameter separated with comma incase of radial kernel
$range_d=$range_c;
@c=split ",",$range_c;  
@d=split ",",$range_d;
@g=split ",",$range_g;
@j=split ",",$range_j;
#print "k:$kernel\tc:@c\td:@d\tg:@g\tj:@j\n";
#exit;
######################    Preparing for svm_learn ##########################

system "cat test_1 test_2 test_3 test_4 test_5  > cat_test";
open (FH,"eval_1");
open (OF,">o_res");
while ($line=<FH>) { if ($line =~ /(.\d)/) {print OF "$1\n";} }
close OF; close FH;

open (OH,">>svm_result") or die "cannot open";

####$$$$$$$$$$$$$$$$$$  Linear    $$$$$$$$$$$$$$$$$  perl /media/data/progs/run_learn_eval.pl 2 1 0.1 1

if ($kernel==2)
{#.t=2 (Radial) g=0.1 j=1 c=1
for ($g1=0;$g1<@g;$g1++)
 {
 {
  for($j1=0;$j1<@j;$j1++)
     {
       for($c1=0;$c1<@c;$c1++)
          {
   			 system "~/progs/svm_learn -z c -t 2 -g $g[$g1] -j $j[$j1] -c $c[$c1] cat_test  model2_g$g[$g1]_j$j[$j1]_c$c[$c1]";


     			 system "~/progs/svm_classify eval_1  model2_g$g[$g1]_j$j[$j1]_c$c[$c1] res2_e$g[$g1]_j$j[$j1]_c$c[$c1]";          
  		         system "cat res2_e$g[$g1]_j$j[$j1]_c$c[$c1] >>p_res2_e$g[$g1]_j$j[$j1]_c$c[$c1]";

			 print OH "\nevaluation set\nKernel Parameters ........t=2 (Radial) g=$g[$g1] j=$j[$j1] c=$c[$c1] \n";
		         system   "~/progs/create_table.pl o_res p_res2_e$g[$g1]_j$j[$j1]_c$c[$c1]";
                         

          }
      }
 }
}
}

