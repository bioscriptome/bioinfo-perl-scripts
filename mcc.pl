use Getopt::Std;

#!/usr/bin/perl

getopts('p:n:f:m:');

$tp=$opt_p;
$tn=$opt_n;
$fp=$opt_f;
$fn=$opt_m;
if($tp eq ''){print '$tp=$opt_p;
$tn=$opt_n;
$fp=$opt_f;
$fn=$opt_m;'."\n";}
else{
$sn = ($tp/($tp+$fn))*100;
if (($tn>0) && ($fp>=0)){
    $sp  = ($tn/($tn+$fp))*100;}
if (($tp>0) && ($tn>0)){
    $acc= ((($tp+$tn)/($tp+$tn +$fp +$fn)))*100;}
$k= $tp+$fp;
$k1= $tp+$fn;
$k2= $tn+$fp;
$k3= $tn+$fn;
$a=$k*$k1*$k2*$k3;
$b= $a**0.5;
$j=$tp*$tn;
$j1= $fp*$fn;
$mc=$j-$j1;
$mcc = $mc/$b;
$ppv=($tp/($tp+$fp));
$npv=($tn/($tn+$fn));
    print "TP\tFP\tFN\tTN\tSN\tSP\tACC\tMCC\tPPV\tNPV\n";
print "$tp\t$fp\t$fn\t$tn\t";
#printf(FP2 "%d:%6.4f ",$count,$c2)\

printf "%5.1f\t",$sn;
#print  "\t$tp\t$fp\t$fn\t$tn\t";
printf "%6.2f\t",$sp;
#printf "%6.2f\t",$scificity;
printf "%6.2f\t",$acc;
printf "%6.2f\t",$mcc;
printf "%6.2f\t",$ppv;
printf "%6.2f\t",$npv;



#t$sn\t$sp\t$acc\t$mcc\n";
}
