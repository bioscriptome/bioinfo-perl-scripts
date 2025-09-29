#!/usr/bin/perl
use strict;
use warnings;
my $file_enzyme=$ARGV[0];
my $file_dna=$ARGV[1];

open DNASEQ, ">$file_dna"."_"."$file_enzyme";
open ENZYME, "$file_enzyme";
open DNA, "$file_dna";
while (<ENZYME>) {
 chomp;
  if( /'(.*)\/\//) { # Extracts the cut point between ' & // in the enzyme file
    my $pattern=$1;
    while (<DNA>) {
     chomp;
     #print $pattern;
     my @output=split/$pattern/,;
     print DNASEQ shift @output,"\n"; #first recognized sequence being output
     foreach (@output) {
        print DNASEQ "$pattern$_\n"; #prefixing the remaining sequences with the cut point pattern
     }
   }
 }
}
close DNA;
close ENZYME;
close DNASEQ;

