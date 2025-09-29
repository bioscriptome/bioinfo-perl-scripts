\#!/usr/bin/perl
open (PATTERNFILE,"$ARGV[0]"); ## input for pattern file without any header
@pat=<PATTERNFILE>;
close PATTERNFILE;


$tag=$ARGV[1];  ## input for tag u want to add with counter
open (OUT,">$ARGV[2]");


$count=1;
foreach (@pat)
{
chomp $_;

#$_ =~ /(.+?) ##(.+)/; $head=$1; $seq=$2; print "$head\n$seq\n";  ## from SFASTA to FASTA format

print  ">$tag\_$count\n$_\n";  ## from patterns to fasta
$count++;
}

close OUT;
