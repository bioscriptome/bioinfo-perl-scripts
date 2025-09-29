#!/usr/perl/bin
open(FH,@ARGV[0]);
open(FA,">".$ARGV[1]);
@array=<FH>;
$a="1,0,0,0";
$b="0,1,0,0";
$c="0,0,1,0";
$d="0,0,0,1";
foreach $line(@array){
chomp($line);
$i=0;
chop($line);
($effi,$seq)=split("\t",$line);
print FA ($effi)." " ; 
$seq=~s/\s//g;
@seq=split("",$seq);
foreach $nt(@seq){
if($nt=~/[Aa]/){print FA ++$i.":1 ".++$i.":0 ".++$i.":0 ".++$i.":0 ";}
if($nt=~/[Gg]/){print FA ++$i.":0 ".++$i.":1 ".++$i.":0 ".++$i.":0 ";}
if($nt=~/[Cc]/){print FA ++$i.":0 ".++$i.":0 ".++$i.":1 ".++$i.":0 ";}
if($nt=~/[Tt]/){print FA ++$i.":0 ".++$i.":0 ".++$i.":0 ".++$i.":1 ";}
}
$bin=join(", ",@array);
print FA "\n";
}
close FH;
close FA;
#$file1=$ARGV[1];
#open (FF,$file1);
#open (TF,">comp_shuf.txt");
#while ($line1=<FF>)
#{
#  while ($line2=<SF>)
#  {
#     print TF "$line1$line2";
#     $line1=<FF>;
#  }
#}
#close FF;
#close TF;
open (CF,$ARGV[1]);
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
print OS5 "$line";$line=<CF>;
print OS6 "$line";$line=<CF>;
print OS7 "$line";$line=<CF>;
print OS8 "$line";$line=<CF>;
print OS9 "$line";$line=<CF>;
print OS10 "$line";
}
close CF,OS1,OS2,OS3, OS4, OS5,OS6,OS7,OS8, OS9, OS10;
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

