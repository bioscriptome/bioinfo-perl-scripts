#!/usr/bin/perl

use Getopt::Std;
getopts('a:b:');

$file_pos=$opt_a;
$file_neg=$opt_b;

open (POSITIVEPAT,">$file_pos");
open (NEGATIVEPAT,">$file_neg");

open (TEMPPOS2,"temp_pos2") or die "Can't open this file $filename : $!";
while ($pos2=<TEMPPOS2>)
{
chomp $pos2;
$file=$pos=""; @pos=();@pat=();
$pos2 =~ /(.+?):(.+)/; $file=$1; $pos=$2;
@pos=split'\t',$pos;	

@pos=sort { $a <=> $b } @pos;  ## Sorted @pos numbers but repeated numbers exist

my %seen = ();
@pos = grep { ! $seen{$_} ++ } @pos;   ## making @pos uniq array

#print "POS2:$pos[0]\t$pos[-1]\n";

$start=$pos[1]; $end=$pos[-1]; ## Shud not take any motifs in between start and end. Take other region for negative motifs

#print "START:$start\tEnd:$end\n";

open (PATFILE,"$file.pat");
@pat=<PATFILE>; close PATFILE;  ## Zeroth element of @pat contains header line so can leave

for ($c=1;$c<@pat;$c++){  ## pattern starting from 1 so line number resembles exact pattern in need
$find=0;
 for ($d=0;$d<@pos;$d++) { if ($pos[$d] == $c) { $find++; } }
if 	($find != 0)     					{ print POSITIVEPAT "$pat[$c]"; }
elsif	(($find == 0) && (($c < $start) || ($c > $end))  )      { print NEGATIVEPAT "$pat[$c]"; }  

                       }
}

close TEMPPOS2;
close POSITIVEPAT;
close NEGATIVEPAT;

