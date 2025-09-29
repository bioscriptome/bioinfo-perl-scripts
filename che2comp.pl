#!/usr/bin/perl
# Program to calculate composition of C/H/E from the .pat file
# .pat file looks like below

# Pattern Window size 19 generated from PSSM matrix. Each line represents pattern for central residue
# 0,0,0,0,0,0,0,0,0,C,C,E,E,E,C,C,C,C,E
# 0,0,0,0,0,0,0,0,C,C,E,E,E,C,C,C,C,E,E


open (FILE,"$ARGV[0]");   ## pattern file containing CHE pos.pat/neg.pat 
open (COMP,">$ARGV[1]");  ## Output File containing composition 
while ($pat=<FILE>)
{
chomp $pat;
@pat1=(); $c=$h=$e=$comp_c=$comp_h=$comp_e=0;

if ($pat !~ /#/)  { 

@pat1=split",",$pat;
foreach (@pat1)  
 {
  if ($_ eq 'C') {$c++;}
  if ($_ eq 'H') {$h++;}
  if ($_ eq 'E') {$e++;}	
 }

$len=scalar @pat1;

$comp_c=($c/$len)*100;
$comp_h=($h/$len)*100;
$comp_e=($e/$len)*100;

print COMP "$comp_c,$comp_h,$comp_e\n";
		  }
}
close FILE;
close COMP;
