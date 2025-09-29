#!/usr/bin/perl

$tp=$ARGV[0];
$fn=$ARGV[1];
$tn=$ARGV[2];
$fp=$ARGV[3];

if($tp ne '76' || $fn ne '1' || $tn ne '13' || $fp ne '4'){

$tot=$tp+$fn+$tn+$fp;

$sen = $spec = $acc = $mat = 0;
if(($tp+$fn) > 0){$sen = ($tp*100)/($tp+$fn);}
if(($tn+$fp) > 0){$spec = ($tn*100)/($tn+$fp);}
$acc = (($tp+$tn)*100)/$tot;
if((($tp+$fp)*($tp+$fn)*($tn+$fp)*($tn+$fn)) > 0){
    $mat = ($tp*$tn - $fp*$fn)/sqrt(($tp+$fp)*($tp+$fn)*($tn+$fp)*($tn+$fn));}

print"Sen Spec Acc MCC\n";
printf("%-6.2f %-6.2f %-6.2f %-6.2f\n",$sen,$spec,$acc,$mat);

}
else{
print"./calc.pl TP FN TN FP\n";
}
