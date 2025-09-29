#!/usr/bin/perl                                                                                                                                              
#####    Program reads two composition files and shuffles all the sequences to create training and testing sets #########                                    
$file1=$ARGV[0];  ## Shud be equal or less in number as compared to 2nd file
open (CF ,$file1);
open (OS1,">set1");
open (OS2,">set2");
open(OS3,">set3");
open(OS4,">set4");
open(OS5,">set5");
open (OS6,">set6");
open (OS7,">set7");
open(OS8,">set8");
open(OS9,">set9");
open(OS10,">set10");
while ($line=<CF>)
{
print OS1 "$line";$line=<CF>;
print OS2 "$line";$line=<CF>;
print OS3 "$line";$line=<CF>;
print OS4 "$line";$line=<CF>;
print OS5 "$line";$line=<CF>;
print OS6 "$line";$line=<CF>;
print OS7 "$line";$line=<CF>;
print OS8 "$line";$line=<CF>;
print OS9 "$line";$line=<CF>;
print OS10 "$line";
}
close CF,OS1,OS2,OS3, OS4, OS5,OS6,OS7,OS8, OS9, OS10;
####################### Creating Testing and Training sets  ############################                                                                     

system "cat set1 set2 set3 set4 set5 set6 set7 set8 set9  >train_1";
system "cat set1 set2 set3 set4 set5 set6 set7 set8  set10 >train_2";
system "cat set1 set2 set3 set4 set5 set6 set7  set9 set10  >train_3";
system "cat set1 set2 set3 set4 set5 set6  set8 set9 set10  >train_4";
system "cat set1 set2 set3 set4 set5 set7 set8 set9 set10 >train_5";
system "cat set1 set2 set3 set4 set6 set7 set8 set9 set10 >train_6";
system "cat set1 set2 set3 set5 set6 set7 set8 set9 set10 >train_7";
system "cat set1 set2 set4 set5 set6 set7 set8 set9 set10 >train_8";
system "cat set1 set3 set4 set5 set6 set7 set8 set9 set10 >train_9";
system "cat set2 set3 set4 set5 set6 set7 set8 set9 set10 >train_10";

system "cp set10 test_1";
system "cp set9 test_2";
system "cp set8 test_3";
system "cp set7 test_4";
system "cp set6 test_5";
system "cp set5 test_6";
system "cp set4 test_7";
system "cp set3 test_8";
system "cp set2 test_9";
system "cp set1 test_10";

system "cut -f1 -d ' ' test_1 > score_1 ";
system "cut -f1 -d ' ' test_2 > score_2 ";
system "cut -f1 -d ' ' test_3 > score_3 ";
system "cut -f1 -d ' ' test_4 > score_4 ";
system "cut -f1 -d ' ' test_5 > score_5 ";
system "cut -f1 -d ' ' test_6 > score_6 ";
system "cut -f1 -d ' ' test_7 > score_7 ";
system "cut -f1 -d ' ' test_8 > score_8 ";
system "cut -f1 -d ' ' test_9 > score_9 ";
system "cut -f1 -d ' ' test_10 > score_10 ";


#system "rm set1 set2 set3 set4 set5";
