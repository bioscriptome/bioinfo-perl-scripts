#!/usr/bin/perl
# Translate a DNA sequence in all six reading frames
use lib "/home/nishant/progs/sub";
if($ARGV[0] eq ''){print "PLZ Enter DNA seq\n";}

use warnings;
use SUB;     # see Chapter 6 about this module
if($ARGV[0] eq ''){print "perl programe.pl ntsfasta output";}
else{
# Initialize variables
 @file_data = (  );
 $dna = '';
$revcom = '';
 $protein = '';
@frame=();
# Read in the contents of the file "sample.dna"

#@file_data = get_file_data("sample.dna");

# Extract the sequence data from the contents of the file "sample.dna"
#######$dna = extract_sequence_from_fasta_data(@file_data);
open(FO,$ARGV[0]);
if($ARGV[2] eq 'all'){open(FA,">$ARGV[1]");}
if($ARGV[2] eq '1'){open(FA1,">$ARGV[1].1st");}
if($ARGV[2] eq '2'){open(FA2,">$ARGV[1].2nd");}
if($ARGV[2] eq '3'){open(FA3,">$ARGV[1].3rd");}
if($ARGV[2] eq '4'){open(FA4,">$ARGV[1].4th");}
if($ARGV[2] eq '5'){open(FA5,">$ARGV[1].5th");}
if($ARGV[2] eq '6'){open(FA6,">$ARGV[1].6th");}
if($ARGV[2] eq '12'){open(FA12,">$ARGV[1].1n2");}
if($ARGV[2] eq '13'){open(FA13,">$ARGV[1].1n3");}
if($ARGV[2] eq '23'){open(FA23,">$ARGV[1].2n3");}
if($ARGV[2] eq '123'){open(FA123,">$ARGV[1].1n2n3");}
if($ARGV[2] eq '65'){open(FA65,">$ARGV[1].6n5");}
if($ARGV[2] eq '64'){open(FA64,">$ARGV[1].6n4");}
if($ARGV[2] eq '54'){open(FA54,">$ARGV[1].5n4");}
if($ARGV[2] eq '654'){open(FA654,">$ARGV[1].6n5n4");}
@array=<FO>;
close FO;
foreach $line(@array){chomp($line);
 @line=split("##",$line);
$dna=$line[1];
$id=$line[0];
@frame=SUB::sixframe($dna);
print "\n -------Reading Frame 1--------$frame[0]\n";
		      if($ARGV[2] eq '1'){print FA "$id##$frame[0]\n";}
		      if($ARGV[2] eq '2'){print FA2 "$id##$frame[1]\n";}
		    if($ARGV[2] eq '3'){print FA3 "$id##$frame[2]\n";}
		    if($ARGV[2] eq '4'){print FA4 "$id##$frame[3]\n";}
		      if($ARGV[2] eq '5'){print FA5 "$id##$frame[4]\n";}
		      if($ARGV[2] eq '6'){print FA6 "$id##$frame[5]\n";}

		      if($ARGV[2] eq '12'){print FA12 "$id##$frame[0]$frame[1]\n";}
		      if($ARGV[2] eq '13'){print FA13 "$id##$frame[0]$frame[2]\n";}
		      if($ARGV[2] eq '23'){print FA23 "$id##$frame[1]$frame[2]\n";}
		      if($ARGV[2] eq '123'){print FA123 "$id##$frame[0]$frame[1]$frame[2]\n";}
		      if($ARGV[2] eq '65'){print FA65 "$id##$frame[5]$frame[4]\n";}
		      if($ARGV[2] eq '64'){print FA64 "$id##$frame[5]$frame[3]\n";}
		      if($ARGV[2] eq '54'){print FA54 "$id##$frame[4]$frame[3]\n";}
		      if($ARGV[2] eq '654'){print FA654 "$id##$frame[5]$frame[4]$frame[3]\n";}



		      if($ARGV[2] eq 'all'){print FA "$id##$frame[0]$frame[1]$frame[2]$frame[3]$frame[4]$frame[5]\n";}
}exit;
}
