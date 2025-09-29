#!/usr/bin/perl
open (SVMFILE,"$ARGV[0]");
open (COLFILE,">$ARGV[1]");
while ($line=<SVMFILE>)
{
	chomp $line;
	@arr=(); $arr1="";
        @array=split(" 1:",$line);
        $array[0]=~s/ 1/g/;
        $array[1]=~s/[0-9]+:/,/g;
	$array[1]=~s/ //g;
        print COLFILE  "$array[1],$array[0]\n";
}
close SVMFILE;
close COLFILE;
