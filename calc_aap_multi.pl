#!/usr/bin/perl

## Program to multiply matrix value to the column files; column file and matrix file should be of same vector size ie 20 or 400
## Usage: program columnFile matrixFile resFile

open (COL,"$ARGV[0]"); 	 ## column file
open (MAT,"$ARGV[1]"); 	 ## matrix file
open (COL2,">$ARGV[2]"); ## res file
$c=0;
while ($mat=<MAT>) {	chomp $mat; $mat=~/\w+\t(.+)/; $v=$1; $mat[$c]=$v; $c++; } # @mat=split",",$mat;	}
close MAT;
while ($col=<COL>)
{
chomp $col;
$val="";
@vals=split",",$col;
for ($x=0;$x<@vals;$x++)
	{
	$vals[$x]=($vals[$x])*($mat[$x]);
	if ($vals[$x] == '-0') {$vals[$x] = 0;}
	}
$val=join",",@vals;
print COL2 "$val\n";
}
close COL;
close COL2;


