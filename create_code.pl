#!/usr/bin/perl
##########require "/usr1/webserver/cgibin/pseapred2/PPredYeast/progs/base_env";
if($ARGV[0] eq ''){print "Usage:perl program.pl result('#>seq1@28##KVKLAVLSYYKVDAE,-0.11574742')";}
#>seq1@28##KVKLAVLSYYKVDAE,-0.11574742
#>seq1@46##TKLRRECSNPTCGAG,0.32289899
#>seq1@70##LYCGKCHSVYKVNAX,-0.83994095
#>seq1@10##KRKKKVYTTPKKIKH,-0.81765551
#>seq1@11##RKKKVYTTPKKIKHK,-0.060302597
#>seq1@39##VDAEGKVTKLRRECS,-1.6501612
#>seq1@49##RRECSNPTCGAGVFL,-0.83480823
sub norm1{
($score)=@_;
chomp $score;
$rel=0;
if ($score < -1.0) {$score="-1.0";}
if ($score > 1.0) {$score="1.0";}
if ($score == -0.6) {$score="-0.61";}
for ($x=-1.0;$x<=1.0;$x+=0.1)
   {
	$y=$x+0.1;
	if (($score > $x) && ($score <= $y))
	{
	 print "$rel\n";
         $resu=$rel;
	}
$rel=$rel+0.5;
#if(($rel<6)&&($rel>5.7)){$rel=6;}
	#$rel++;
    }
return $resu;
}







sub norm{
($score_trim)=@_;
chomp $score;
$rel=0;
$score_trim=~s/\s//g;
$score_trim=~s/\n//g;


if($score_trim<=-1.4){;$pscore=0;}
if($score_trim<=-1.3){$pscore=0;}
if($score_trim>-1.3 && $score_trim<=-1.25){$pscore=1;}
if($score_trim>-1.25 && $score_trim<=-0.95){$pscore=2;}
if($score_trim>-0.95 && $score_trim<=-0.8){$pscore=3;}
if($score_trim>-0.8 && $score_trim<=-0.6){$pscore=4;}
if($score_trim>-0.6 && $score_trim<=-0.4){$pscore=5;}
if($score_trim>-0.4 && $score_trim<=-0.17){$pscore=6;}
if($score_trim>-0.17 && $score_trim<=0){$pscore=7;}
if($score_trim>0 && $score_trim<=0.2){$pscore=7.5;}
if($score_trim>0.2 && $score_trim<=0.3){$pscore=8;}
if($score_trim>0.3 && $score_trim<=0.5){$pscore=8.5;}
if($score_trim>0.5 && $score_trim<=0.8){$pscore=9;}
if($score_trim>0.8 && $score_trim<=0.9){$pscore=9.5;}
if($score_trim>0.9 && $score_trim<=1.1){$pscore=9.7;}
if($score_trim>1.1 && $score_trim<=1.2){$pscore=9.9;}
if($score_trim>1.2){$pscore=10;}




return $pscore;
}







$ids=$ARGV[4];
$thres=$ARGV[6];
#$name=
$tmp=$ARGV[2];$lengthl=$ARGV[3];open(RESF,">$tmp/result$ids");
open(RES,"$tmp/result1_$ids");@result=<RES>;
close RES;
print "$tmp/";
#open(RES1,">$tmp/result");
open(S,">$tmp/ssites$ids");
open(T,">$tmp/tsites$ids");
open(TH,">$tmp/thres$ids");

@sites=();$me=0;
#print RES1 "0\t10\n";
foreach $nis(@result){
    @get_part=split('@',$nis);
    @parts=split(',',$get_part[1]);
print RESF "$get_part[0]\@$parts[0],";
    @pos=split('##',$parts[0]);
$sc=$parts[1];
$sc=norm($sc);
print RESF "$sc\n";
$sc=~s/[\n\r\s]//g; 
    if($pos[1]=~/[A-Z]{7}([ST])[A-Z]{7}/){
    $residue=$1;}
    $score=$sc;
    $me++;
    $score[$me-1]=$score;
   # print RES1 "$me\t$score\n";
    $sites[$me-1]="$pos[0]$residue";
$score=$score*10;
if($residue eq 'S'){$S[$me-1]="$pos[0]\t$score\n";}
if($residue eq 'T'){$T[$me-1]="$pos[0]\t$score\n";}
}
foreach $SS(@S){print S $SS;}
foreach $TT(@T){print T $TT;}
$size_l=scalar(@sites);
$lat=$size_l+1;
if($lengthl < 50){$rangex=5;}
if($lengthl > 50 && $lengthl < 100){$rangex=10;}
if($lengthl > 100 && $lengthl < 200){$rangex=15;}
if($lengthl > 200 && $lengthl < 400){$rangex=25;}
if($lengthl > 400 ){$rangex=100;}



print TH "0\t$thres\n$lengthl\t$thres";
system "paste $tmp/ssites$ids $tmp/tsites$ids $tmp/thres$ids >$tmp/result$ids";
print "paste $tmp/$ssites$ids $tmp/$tsites$ids $tmp/$thres$ids >$tmp/result$ids";
close S,T,TH;
$lar=max(@score);
$ran=$me+1;
print $lar."\n";
close RES1;
print $tmp;
print "$tmp/code$ids";
open(FA,">$tmp/code$ids");
print FA "set out \"$tmp/simpletext$ids.jpg\"\n";
print FA "set terminal png\n";
print FA "set grid\n";
print FA "set ylabel \"Phosphorylation Probabilty\"\n";
print FA "set xlabel \"S/T position in sequnece\"\n";
print FA "set xrange [0:$lengthl]\n";
print FA "set yrange[0:100]\n";
print FA "set data style boxes\n";
print FA "set boxwidth 0.1\n";
print FA "set style fill solid\n";
print FA "set bar\n";
print FA "set ytics 10\n";
print FA "set xtics $rangex\n";
$strs=$strt="(";
$counts=$countt=0;
foreach $n(@S){
$counts++;
$strs.= "\"".$n."\" ".$counts.",";
}
foreach $n1(@T){
$countt++;
$strt.= "\"".$n1."\" ".$countt.",";
}

chop($strs);chop($strt);
$strfs=$strs.")";
$strft=$strt.")";

#print FA $strf."\n";
print FA "plot \"$tmp/result$ids\" using (\$1):(\$2) title \"S residues\",\"$tmp/result$ids\" using (\$3):(\$4) title \"T residues\", \"$tmp/result$ids\" using (\$5):(\$6) title \"Threshold 60(60%)\" with lines ,\"$tmp/pdis$ARGV[5]-\" using (\$1):(\$3) title \"Disorderness(0 least and  100 most)\" with lines";
system "/usr/bin/gnuplot $tmp/code$ids";

#print FA "pause 0";
sub max 
{ my $max = pop(@_); 
foreach (@_) 
{ $max = $_ if $_ > $max; 
} 
$max; 
} 
