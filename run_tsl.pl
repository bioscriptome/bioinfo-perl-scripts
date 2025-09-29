#!/usr/bin/perl
use Getopt::Std;
getopts('p:n:o:m:');
$pos=$opt_p;
$neg=$opt_n;
$matrix=$opt_m;
$out=$opt_o;
system "perl ~/progs/run_tsl_class.pl -i $pos -m $matrix -o $out.pos";
system "perl ~/progs/run_tsl_class.pl -i $neg -m $matrix -o $out.neg";
