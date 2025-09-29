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

system "cat test_1 test_2 test_3 test_4 test_5 >> cat_test";
open (FH,"cat_test");
open (OF,">>o_res");
while ($line=<FH>) { if ($line =~ /(.\d)/) {print OF "$1\n";} }
close OF; close FH;

open (OH,">>svm_result") or die "cannot open";

####$$$$$$$$$$$$$$$$$$  Linear    $$$$$$$$$$$$$$$$$

if ($kernel==0)
  {
#$c=1-1000
print "**********************\nSVM is running in Linear kernel -t=0 with following parameters:\nc=@c\n************************\n";
   for($c1=0;$c1<@c;$c1++)
    {
     for ($t=1;$t<6;$t++)
       {
            system "/usr1/webserver/cgidocs/raghava/thakur/progs/svm_learn -z c -t 0 -c $c[$c1] train_$t model0_c$c[$c1]_$t";
            system "/usr1/webserver/cgidocs/raghava/thakur/progs/svm_classify test_[$t] model0_c$c[$c1]_$t res0_c$c[$c1]_$t";
            system "cat res0_c$c[$c1]_$t >> p_res0_c$c[$c1]";
       }
        print OH "\n\nKernel Parameters ........t=0 (Linear) c=$c[$c1]  \n";
        system  "/usr1/webserver/cgidocs/raghava/thakur/progs/create_table.pl o_res p_res0_c$c[$c1]";
    }  
        system "rm res0* o_res cat_test model0_c* p_res0_c*";
        close OH;
        exit;
  }

####################  Finished Linear Model ###########
################### Polynomial Model #################

if ($kernel==1)
{
# @d=1-5
print "**********************\nSVM is running in Polynomial kernel -t=1 with following parameters:\nd=@d\n************************\n";
 for ($d1=0;$d1<@d;$d1++)
  {
   for ($t=1;$t<6;$t++)
      {
           system "/usr1/webserver/cgidocs/raghava/thakur/progs/svm_learn -z c -t 1 -d $d[$d1] train_$t model1_d$d[$d1]_$t";
           system "/usr1/webserver/cgidocs/raghava/thakur/progs/svm_classify test_[$t] model1_d$d[$d1]_$t res1_d$d[$d1]_$t";
           system "cat res1_d$d[$d1]_$t >>p_res1_d$d[$d1]";
      }
   
        print OH "\n\nKernel Parameters ........t=1 (Polynomial) d=$d[$d1] \n";
        system  "/usr1/webserver/cgidocs/raghava/thakur/progs/create_table.pl o_res p_res1_d$d[$d1]";
  }
         system "rm res1* o_res cat_test p_res1* model1_d*";
         close OH;
         exit;
}


##################   Finished Polynomial Model ########
################## Start t=2 Model ######################
if ($kernel==2)
{
# @g=qw(0.0001 0.0010 0.0100 0.1000 1.0000 10.0000);
# @j=1-15
# @c=1-500
print "**********************\nSVM is running in Radial kernel -t=2 with following parameters:\ng=@g\nj=@j\nc=@c\n************************\n";
for ($g1=0;$g1<@g;$g1++)
 {
  for($j1=0;$j1<@j;$j1++)
     {
       for($c1=0;$c1<@c;$c1++)
          {
            for ($t=1;$t<6;$t++)
             {
    system "/usr1/webserver/cgidocs/raghava/thakur/progs/svm_learn -z c -t 2 -g $g[$g1] -j $j[$j1] -c $c[$c1] train_$t model2_g$g[$g1]_j$j[$j1]_c$c[$c1]_$t";
    system "/usr1/webserver/cgidocs/raghava/thakur/progs/svm_classify test_[$t] model2_g$g[$g1]_j$j[$j1]_c$c[$c1]_$t res2_g$g[$g1]_j$j[$j1]_c$c[$c1]_$t";
    system "cat res2_g$g[$g1]_j$j[$j1]_c$c[$c1]_$t >>p_res2_g$g[$g1]_j$j[$j1]_c$c[$c1]";
             }
           print OH "\n\nKernel Parameters ........t=2 (Radial) g=$g[$g1] j=$j[$j1] c=$c[$c1] \n";
           system   "/usr1/webserver/cgidocs/raghava/thakur/progs/create_table.pl o_res p_res2_g$g[$g1]_j$j[$j1]_c$c[$c1]";
          }
      }
 }
system "rm res2_* cat_test model2*";
#system "rm o_res p_res2*";
close OH;
exit;
} # closing 'if' loop
