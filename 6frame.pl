#!/usr/bin/perl
# Translate a DNA sequence in all six reading frames
use lib "/home/nishant/progs/sub";

#use strict;
use warnings;
use SUB;     # see Chapter 6 about this module

# Initialize variables
#my @file_data = (  );
#my $dna = '';
#my $revcom = '';
#my $protein = '';
#my @frame=();
open(FH,$ARGV[0]);
open(FA,">$ARGV[1]");

@eff_seq=<FH>;close FH;
# Read in the contents of the file "sample.dna"

#@file_data = get_file_data("sample.dna");

# Extract the sequence data from the contents of the file "sample.dna"
#######$dna = extract_sequence_from_fasta_data(@file_data);
foreach $line(@eff_seq){
($eff,$dna)=split(" ",$line);
#$dna =$ARGV[0];
#print $dna."\n";
print FA ">".$eff.'##';
@frame=SUB::sixframe($dna);
#print "\n -------Reading Frame 1--------\n\n";
print FA $frame[0];

#print "\n -------Reading Frame 2--------\n\n";
print FA $frame[1];

#print "\n -------Reading Frame 3--------\n\n";
print FA $frame[2];

#print "\n -------Reading Frame 4--------\n\n";
print FA $frame[3];

#rint "\n -------Reading Frame 5--------\n\n";
print FA $frame[4];

#rint "\n -------Reading Frame 6--------\n\n";
print FA $frame[5]."\n";
}
close FA;
open(FO,$ARGV[1]);
@eff_seq=<FO>;close FO;
open(SCORE,">$ARGV[1].SCORE");

foreach $line (@eff_seq){$line=~s/>//g;
($eff,$seq)=split("##",$line);
print SCORE $eff."\n";

}
exit;
