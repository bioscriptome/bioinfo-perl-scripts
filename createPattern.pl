#!/usr/bin/perl

open (LISTPDB,"$ARGV[0]");   ## 'listPdb.txt'
while ($pdb=<LISTPDB>)
{
chomp $pdb;
#system "/home/rahman/PROJECTS/Bepitope/psipred/ss2Matrix.pl $pdb.ss $pdb.mat";
system "perl psipredMat2pat.pl -i $pdb.str -w $ARGV[1] -o $pdb.pat";
}
close LISTPDB;
