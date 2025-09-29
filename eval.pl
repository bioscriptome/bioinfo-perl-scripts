#!/usr/bin/perl
# Usage: program file1 (actual values)  file2 (predicted values) 
# file 1 and file2 have values in first colomn

$file1=$ARGV[0];
$file2=$ARGV[1];
$thr = $ARGV[2];
$tot = 0;
open(FP1,"$file1");
open(FP2,"$file2");
$tp = $tn = $fp = $fn = 0;
while($t1=<FP1>){
    $t2=<FP2>;
    chomp($t1);
    chomp($t2);
    $tot++;
    @ti1 = split(" ",$t1);
    @ti2 = split(" ",$t2);
    if($ti2[0] >= $thr){$k3 = +1;}else{$k3 = -1;}
if($ti1[0] == +1){if($k3 == +1){$tp++;}else{$fn++}}
if($ti1[0] == -1){if($k3 == -1){$tn++;}else{$fp++}}
}

close FP1;
close FP2;
$sen = $spec = $acc = $mat = 0;
if(($tp+$fn) > 0){$sen = ($tp*100)/($tp+$fn);}
if(($tn+$fp) > 0){$spec = ($tn*100)/($tn+$fp);}
$acc = (($tp+$tn)*100)/$tot;
if((($tp+$fp)*($tp+$fn)*($tn+$fp)*($tn+$fn)) > 0){
    $mat = ($tp*$tn - $fp*$fn)/sqrt(($tp+$fp)*($tp+$fn)*($tn+$fp)*($tn+$fn));}

printf("%-6.2f %-6.2f %-6.2f %-6.2f\n",$sen,$spec,$acc,$mat);







