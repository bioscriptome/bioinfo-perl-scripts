#/usr/bin/perl
#usage perl program.pl DNAfile OUTfile
use CODON;use Pattern;
use lib "/home/nishant/progs/sub";
require "/home/nishant/progs/env";
my $progs="/home/nishant/progs/";
my $gpsr="/home/nishant/gpsr_1.0/bin/";
use strict;
use warnings;
use SUB;  

open(SCORE,$ARGV[0]);#score file
open(F1,$ARGV[1]);#first file
open(F2,$ARGV[2]);#second file
my @f1=<SCORE>;
my @f2=<F1>;
my @f3=<F2>;

my $len1=scalar(@f1);
my $len2=scalar(@f2);
my $len3=scalar(@f3);
if($len1 eq $len2 && $len2 eq $len3){#print "equal\n";
			for (my $i=0;$i<$len1;$i++){
					chomp($f1[$i]);chomp($f2[$i]);chomp($f3[$i]);
					my $hybrid=$f2[$i].",".$f3[$i];$hybrid=~s/\s//g;
					my @hybrid=split(",",$hybrid);
					print $f1[$i]." ";my $start=0;
					foreach my $hybrid1(@hybrid){
							$start++;
							print $start.":$hybrid1 ";
							#."\t".$f2[$i]."\t".$f3[$i]."\n";
							
					}print "\n";


			}



}

