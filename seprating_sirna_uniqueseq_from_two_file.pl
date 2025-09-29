open(FH,$ARGV[0]);#first file1 should b larger then second file
open(FH1,$ARGV[1]);#second file
open(RF,">A$RG[2]");#result file;

@ff=<FH>;
@sf=<FH1>;
close FH,FH1;
foreach $ff(@ff){chomp($ff);
@feild1=split("\t",$ff);
$seq1=$feild1[0];
$seq1=~s/\s//g;
$seq1=lc($seq1);
$seq1=~s/t/u/g;
#print $seq1."\t";
foreach $sf(@sf){chomp($sf);
@feild2=split("\t",$sf);
$seq2=$feild2[0];
$seq2=~s/\s//g;
$seq2=lc($seq2);
$seq2=~s/t/u/g;
#print $seq2."\n";
if($seq1 eq $seq2){print RF $seq1."\n\n";}
}
}
