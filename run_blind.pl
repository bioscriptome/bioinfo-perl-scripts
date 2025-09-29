#!/usr/bin/perl
$blind=$ARGV[0]; # Enter Kernel value ie '0' for Linear, '1' for Polynomial and '2' for Radial
$c=$ARGV[1];# Enter values of c/d/ parameter separated with comma
$g=$ARGV[2];# Enter values of g parameter separated with comma incase of radial kernel
$j=$ARGV[3];# Enter values of j parameter separated with comma incase of radial kernel
$d=$range_c;
if($ARGV[0] eq ''){print '$blind=$ARGV[0]; # Blind data svm file
$c=$ARGV[1];# Enter values of c/d/ parameter separated with comma
$g=$ARGV[2];# Enter values of g parameter separated with comma incase of radial kernel
$j=$ARGV[3];# Enter values of j parameter separated with comma incase of radial kernel
'}
#@c=split ",",$range_c;  
#@d=split ",",$range_d;
#@g=split ",",$range_g;
#@j=split ",",$range_j;
#print "k:$kernel\tc:@c\td:@d\tg:@g\tj:@j\n";
#exit;
######################    Preparing for svm_learn ##########################

system "cat test_1 test_2 test_3 test_4 test_5 > cat_test";
open (FH,"cat_test");
open (OF,">o_res");
while ($line=<FH>) { if ($line =~ /(.\d)/) {print OF "$1\n";} }
close OF; close FH;

open (OH,">>svm_result_blind") or die "cannot open";
if ($blind ne '' && $c ne '' && $g ne '' && $j ne ''){
system "cut -d ' ' -f1  $blind>tags";
    print "\n-g $g[$g1] -j $j[$j1] -c $c[$c1]\n";
    system "/home/nishant/progs/svm_learn -z c -t 2 -g $g -j $j -c $c cat_test model_g$g_j$j_c$c";
    system "/home/nishant/progs/svm_classify cat_test model_g$g_j$j_c$c res2_g$g_j$j_c$c";
    system "/home/nishant/progs/svm_classify $blind model_g$g_j$j_c$c out_tag";
   # system "cat res2_g$g[$g1]_j$j[$j1]_c$c[$c1]_$t >>p_res2_g$g[$g1]_j$j[$j1]_c$c[$c1]";
print OH "INTERNAL g:$g j:$j c:$c\n";
    system   "/home/nishant/progs/create_table.pl o_res res2_g$g_j$j_c$c $g $c $j";
print OH "ON blind $blind g:$g j:$j c:$c\n";
    system   "/home/nishant/progs/create_table.pl tags out_tag $g $c $j";
 }
#system "rm res2_* cat_test model2*";
close OH;
exit;

