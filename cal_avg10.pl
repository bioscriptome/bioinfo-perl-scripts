#!/usr/bin/perl

open(MAT,">averageRESULT");
open(MAN,"$ARGV[0]");
while($line=<MAN>)
{
    chomp($line);
    if($line=~/test_1.pat/)
    {   
	$avg=$b/10;
	if($avg!=0)
	{
	    print MAT"$avg\n\n";
	}
	$line=~/-------RBF kernel---(G=[0-9\.]+)----(C=[0-9\.]+)---test_1.pat---------/;
	print MAT"AT $1 & $2 average=";
	$avg=$b=0;
    } 
    
    if($line!~/kernel/)
    {    
	$a=0;
	$n++;
	@aa=split(/=/,$line);
	$a=$aa[1];
	$b=$b+$a;
    }
}
$avg=$b/10;
print MAT"$avg\n";

