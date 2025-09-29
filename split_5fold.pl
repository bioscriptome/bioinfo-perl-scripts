#!/usr/bin/perl

$file =$ARGV[0];
open(FP,"$file");
while ($line=<FP>){
   chomp($line);
   $seq[$i] = $line;
   $i++;
}
   for ($i=0;$i<@seq;$i++){
    $n=$i;
    if ($n>4){
	$n= $n%5;
    }
    if ($n==0){
    open (FP, ">>set1");
    print FP "$seq[$i]\n";
}     
    if ($n==1){
    open (FP1, ">>set2");
    print FP1 "$seq[$i]\n";
}
    if ($n==2){
    open (FP2, ">>set3");
    print FP2 "$seq[$i]\n";
}
    if ($n==3){
    open (FP3, ">>set4");
    print FP3 "$seq[$i]\n";
}
    if ($n==4){
    open (FP4, ">>set5");
    print FP4 "$seq[$i]\n";
} 
}
