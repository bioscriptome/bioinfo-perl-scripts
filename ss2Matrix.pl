#!/usr/bin/perl
## Program from ss2 .mat/.str files comment the lines accordingly
open (PDBSS ,"$ARGV[0]"); 		## enter listPDB file generated from psipred software
while ($pdb=<PDBSS>)
{
chomp $pdb;
open (SS,"$pdb.ss");   		 ## reading .ss file
#open (PSSMFORMAT,">$pdb.mat");  ## output file Matrix format .mat
open (STR,">$pdb.str");  	 ## output file Residue, secondary structure format .str
while ($line=<SS>)
{
chomp $line;
$res=$c=$h=$e="";
$line =~ /\d+\s+(\w)\s+(\w)\s+(.+?)\s+(.+?)\s+(.+)/; 
$res=$1; $ss=$2; $c=$3; $h=$4;$e=$5; 
#print PSSMFORMAT "$res, $c, $h, $e\n"; ## for .mat
print STR "$res, $ss\n"; 		## for .str; For  res,ss format
#print STR "$ss";
}
#print STR "\n";
close SS;
#close PSSMFORMAT;			## for .mat
close STR;				## for .str

} 
close PDBSS;
