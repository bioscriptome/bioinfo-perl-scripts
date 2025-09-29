#!/usr/bin/perl

#	Usage: program fullMotifFile positiveMotifFile outputFileNegativeMotifFile

open (ALL,"$ARGV[0]"); ## Input for full motif File

open (FH,"$ARGV[1]");  ## Input for positive motif File
@actual_motif=<FH>; close FH;
$pos_mot=join"",@actual_motif;

open (NEG,">$ARGV[2]");## Input for output File

while ($line=<ALL>)
{
chomp $line;
if ($line =~ /^>/) 
  {
	print NEG "$line\n";
  }
elsif ($pos_mot !~ /$line/)
  {
  	print NEG "$line\n";
  }
} close ALL;
  close NEG;


