#!/usr/bin/perl

#to calculate correlation between observed data(out_$num)and actual data(score_$num) of efficacy;

$file1=$ARGV[0];
$file2=$ARGV[1];
if($file1 ne ''){
open(MAN,"$file1") or die "can't open file";
while($line=<MAN>)
{
    chomp($line);
    $aa[$i]=$line;
    $i++;
}

open(MAT,"$file2") or die "can't open file";
while($lin=<MAT>)
{ 
    chomp($lin);
    $ab[$j]=$lin;
    $j++;
}
$x=$n=$add=$sqx=$sum_sqx=0;
for($c=0;$c<@ab;$c++)
{
    $x=$aa[$c];
    $n++;
    $add=($add+$x);               
    $sqx=$x*$x;
    $sum_sqx=$sum_sqx+$sqx;     #summation x square


    $y=$ab[$c];
    $addy=($addy+$y);
    $sqy=$y*$y;
    $sum_sqy=$sum_sqy+$sqy;
    
    $var=$x*$y;
    $var1=$var1+$var;
}

$x2=$add*$add;                  #summation x whole square
$sd_x=sqrt(($n*$sum_sqx)-$x2);

$y2=$addy*$addy;
$sd_y=sqrt(($n*$sum_sqy)-$y2);

$x3=$add*$addy;                 #summation x into summation y

$cor=$n*$var1;

$correl=($cor-$x3)/($sd_x*$sd_y);

open(MAU,">>RESULT_test");
print MAU"$correl\n";
print "Correlation=$correl\n";
close MAU;
}
if($file1 eq ''){
print' 
    $ARGV[0]=observed
    $ARGV[1]=actual;
';}


























