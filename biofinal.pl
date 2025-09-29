#!/usr/bin/perl
open(FP, "temp");
$line=<FP>;
@ab=split(/\s+/,$line);
for($m=0;$m<@ab;$m++)
{
    @ac=split(/,/, $ab[$m]);
    #print"@ac\n";
}
close FP;
$file=$ARGV[0];
open(FP1, "$file");
open(FP2, ">>out1");
while($line1=<FP1>)
{
    chomp($line1);
    @ab1=split(/\#/, $line1);
    @ac1=split(//, $ab1[1]);
    $len=@ac1;
	for($p=0;$p<@ac1; $p++)
    	{
        if($ac1[$p] eq 'A')
        {
            print FP2 "@ab[0] ";
        }
        if($ac1[$p] eq 'C')
        {
            print FP2 "@ab[1] ";
        }
        if($ac1[$p] eq 'D')
        {
            print FP2 "@ab[2] ";
        }
        if($ac1[$p] eq 'E')
        {
            print FP2 "@ab[3] ";
        }
        if($ac1[$p] eq 'F')
        {
            print FP2 "@ab[4] ";
        }
        if($ac1[$p] eq 'G')
        {
            print FP2 "@ab[5] ";
        }
        if($ac1[$p] eq 'H')
        {
            print FP2 "@ab[6] ";
        }
        if($ac1[$p] eq 'I')
        {
            print FP2 "@ab[7] ";
        }
        if($ac1[$p] eq 'K')
        {
            print FP2 "@ab[8] ";
        }
	if($ac1[$p] eq 'L')
        {
            print FP2 "@ab[9] ";
        }
        if($ac1[$p] eq 'M')
        {
            print FP2 "@ab[10] ";
        }
        if($ac1[$p] eq 'N')
        {
            print FP2 "@ab[11] ";
        }
        if($ac1[$p] eq 'P')
        {
            print FP2 "@ab[12] ";
        }
        if($ac1[$p] eq 'Q')
        {
            print FP2 "@ab[13] ";
        }
        if($ac1[$p] eq 'R')
        {
            print FP2 "@ab[14] ";
        }if($ac1[$p] eq 'S')
        {
            print FP2 "@ab[15] ";
        }
        if($ac1[$p] eq 'T')
        {
            print FP2 "@ab[16] ";
        }
        if($ac1[$p] eq 'V')
        {
            print FP2 "@ab[17] ";
        }
	if($ac1[$p] eq 'W')
        {
            print FP2 "@ab[18] ";
        }
        if($ac1[$p] eq 'Y')
        {
            print FP2 "@ab[19] ";
        }
    }
    print FP2 "\n";
}
close FP1;
close FP2;
open (FP2, "out1");
while($line2=<FP2>)
{
    chomp($line2);
    @ss=split(/\s+/, $line2);
    $l=@ss;
    @sum=$P1=$P2=$P3=$P4=$P5=$P6=$P7=$P8=0;
	for($s=0;$s<@ss;$s++)
    	{
        @ss1=split(/,/, $ss[$s]);
        $P1+=$ss1[0];
        $P2+=$ss1[1];
        $P3+=$ss1[2];
        $P4+=$ss1[3];
        $P5+=$ss1[4];
        $P6+=$ss1[5];
        $P7+=$ss1[6];
        $P8+=$ss1[7];
    	}
    	$sum[1]=($P1/$l);
    	$sum[2]=($P2/$l);
    	$sum[3]=($P3/$l);
    	$sum[4]=($P4/$l);
   	$sum[5]=($P5/$l);
   	$sum[6]=($P6/$l);
    	$sum[7]=($P7/$l);
    	$sum[8]=($P8/$l);
   # print "$sum[1], $sum[2], $sum[3], $sum[4], $sum[5], $sum[6], $sum[7], $sum[8]\n\n\n";
########################################

 for($lg=1;$lg<=13;$lg++)
        {
        $cal1=$cal2=$cal3=$cal4=$cal5=$cal6=$cal7=$cal8=0;
        $cal_1=$cal_2=$cal_3=$cal_4=$cal_5=$cal_6=$cal_7=$cal_8=0;
        $s1=$l-$lg;
        $i=$i1=0;
            for($n=0;$n<$s1;$n++)
                {
                @sp1=split(/,/, $ss[$n]);
                $cal1=$sp1[0]-$sum[1];
                $cal2=$sp1[1]-$sum[2];
                $cal3=$sp1[2]-$sum[3];
                $cal4=$sp1[3]-$sum[4];
                $cal5=$sp1[4]-$sum[5];
                $cal6=$sp1[5]-$sum[6];
                $cal7=$sp1[6]-$sum[7];
                $cal8=$sp1[7]-$sum[8];
                $c1[$i]=$cal1;
                $c2[$i]=$cal2;
                $c3[$i]=$cal3;
                $c4[$i]=$cal4;
                $c5[$i]=$cal5;
                $c6[$i]=$cal6;
                $c7[$i]=$cal7;
                $c8[$i]=$cal8;
 		$i++;
                }
                $s2=0+$lg;

		for($m=$s2;$m<$l;$m++)
                {
                @sp1=split(/,/, $ss[$m]);
                $cal_1=$sp1[0]-$sum[1];
                $cal_2=$sp1[1]-$sum[2];
                $cal_3=$sp1[2]-$sum[3];
                $cal_4=$sp1[3]-$sum[4];
                $cal_5=$sp1[4]-$sum[5];
                $cal_6=$sp1[5]-$sum[6];
                $cal_7=$sp1[6]-$sum[7];
                $cal_8=$sp1[7]-$sum[8];
                $res1[$i1]=$cal_1;
                $res2[$i1]=$cal_2;
                $res3[$i1]=$cal_3;
                $res4[$i1]=$cal_4;
                $res5[$i1]=$cal_5;
                $res6[$i1]=$cal_6;
                $res7[$i1]=$cal_7;
                $res8[$i1]=$cal_8;
                $i1++;
                }
for($k=0;$k<@c1;$k++)
{
$multi1+=$c1[$k]*$res1[$k];
$multi2+=$c2[$k]*$res2[$k];
$multi3+=$c3[$k]*$res3[$k];
$multi4+=$c4[$k]*$res4[$k];
$multi5+=$c5[$k]*$res5[$k];
$multi6+=$c6[$k]*$res6[$k];
$multi7+=$c7[$k]*$res7[$k];
$multi8+=$c8[$k]*$res8[$k];
#printf "%2.3f*%2.3f=%2.3f ",$c7[$k],$res7[$k],$multi7 ;
#printf "%2.3f ",$multi7;
}
$result1=$multi1/($l-$lg);
$result2=$multi2/($l-$lg);
$result3=$multi3/($l-$lg);
$result4=$multi4/($l-$lg);
$result5=$multi5/($l-$lg);
$result6=$multi6/($l-$lg);
$result7=$multi7/($l-$lg);
$result8=$multi8/($l-$lg);
printf "%2.6f %2.6f %2.6f %2.6f %2.6f %2.6f %2.6f %2.6f ", $result1,$result2, $result3, $result4, $result5, $result6, $result7, $result8;
$multi1=$multi2=$multi3=$multi4=$multi5=$multi6=$multi7=$multi8="";
@c1=@c2=@c3=@c4=@c5=@c6=@c7=@c8="";
@res1=@res2=@res3=@res4=@res5=@res6=@res7=@res8="";
#print"\n";
}
print"\n";
}
close FP2;
system("rm out");
