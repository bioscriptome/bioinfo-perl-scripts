#!/usr/bin/perl
### usage perl shuffle.pl pos_23.svm neg_23.svm
#####    Program reads two composition files and shuffles all the sequences to create training and testing sets #########
$file1=$ARGV[0];  ## Shud be equal or less in number as compared to 2nd file
$file2=$ARGV[1];
open (FF,"$file1");
open (SF,"$file2");
open (TF,">comp_shuf.txt");
while ($line1=<FF>)
{
  while ($line2=<SF>)
  {
     print TF "$line1$line2";
     $line1=<FF>;
  }
}
close FF;
close SF;
close TF;
open (CF ,"comp_shuf.txt");
open (OS1,">set1");
open (OS2,">set2");
open(OS3,">set3");
open(OS4,">set4");
open(OS5,">set5");
while ($line=<CF>)
{
print OS1 "$line";$line=<CF>;
print OS2 "$line";$line=<CF>;
print OS3 "$line";$line=<CF>;
print OS4 "$line";$line=<CF>;
print OS5 "$line";
}
close CF;close OS1;close OS2;close OS3;close OS4;close OS5;
system "rm comp_shuf.txt";


####################### Creating Testing and Training sets  ############################

system "cat set1 set2 set3 set4 >train_1";
system "cat set1 set2 set3 set5 >train_2";
system "cat set1 set2 set4 set5 >train_3";
system "cat set1 set3 set4 set5 >train_4";
system "cat set2 set3 set4 set5 >train_5";


system "cp set5 test_1";
system "cp set4 test_2";
system "cp set3 test_3";
system "cp set2 test_4";
system "cp set1 test_5";

system "rm set1 set2 set3 set4 set5";
