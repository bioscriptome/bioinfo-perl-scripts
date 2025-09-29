#!/usr/bin/perl -w
##--code to get n and c terminal 5 and 10 mers of amino acids--##
$filein=$ARGV[0]; ##--input single line multipeptide sequence
$file1=$ARGV[1]; ##--outpuut--n5
$file2=$ARGV[2]; ##--output--n10
$file3=$ARGV[3]; ##--output--c5
$file4=$ARGV[4]; ##--ouput--c10
open(FH, $filein);
open(FP1,">".$file1);
open(FP2,">".$file2);
open(FP3,">".$file3);
open(FP4,">".$file4);
while($line=<FH>){
	chomp $line;
	$part1=substr($line,0,5);print FP1 $part1."\n";
	$part2=substr($line,0,10);print FP2 $part2."\n";
	$line=reverse($line);
	$part3=substr($line,0,5);
	$part3=reverse($part3);print FP3 $part3."\n";
	$part4=substr($line,0,10);
	$part4=reverse($part4);print FP4 $part4."\n";
	
}
