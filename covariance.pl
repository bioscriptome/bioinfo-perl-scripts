#!/usr/bin/perl
if($ARGV[0] eq ''){print "ARGV[0]=1st score file \n eg 0.02\n0.57\nARGV[0]=2nd score file \n eg 0.027\n0.47\n"}
open(FH1,$ARGV[0]);
open(FH2,$ARGV[1]);

@array1=<FH1>;
@array2=<FH2>;
close FH1,FH2;
$i=$j=$add1=$add2=$avg==0;
foreach $score1(@array1){chomp($score1);$score1[$i++]=$score1;$add1+=$score1;}
foreach $score2(@array2){chomp($score2);$score2[$j++]=$score2;$add2+=$score2;}
$avg1=$add1/$i;$avg2=$add2/$j;
print $avg1."\t".$avg2;
for($next=0;$next<@score1;$next++){
	$mult_col[$next]=$score1[$next]*$score2[$next];
}
foreach $mult_col(@mult_col){chomp($mult_col);$add_mult_col+=$mult_col;$avg++}
$mult_avg12=$avg1+$avg2;
$avg_mc=$add_mult_col/$avg;
$covariance=$mult_avg12-$avg_mc;
