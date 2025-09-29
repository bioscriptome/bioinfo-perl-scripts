#!/usr/bin/perl 
#require "/home/rahman/PROJECTS/gpsr/gpsr_1.0/includes/base_env";
##############################################################################
##    'pssm2pat' is free software: you can redistribute it and/or modify     #
##    it under the terms of the GNU General Public License as published by   #
##    the Free Software Foundation, either version 3 of the License, or      #
##    (at your option) any later version.                                    #
##############################################################################
##    This program is distributed in the hope that it will be useful,        #
##    but WITHOUT ANY WARRANTY; without even the implied warranty of         #
##    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the          #
##    GNU General Public License for more details.                           #
##                                                                           #
##    You should have received a copy of the GNU General Public License      #
##    along with this program.  If not, see <http://www.gnu.org/licenses/>.  #
##############################################################################
## Orginally developed at Raghava's group <http://www.imtech.res.in/raghava/>#  
## by Hifzur Rahman Ansari, GPS Raghava                                      #
##############################################################################
#=================================================================
# program is designed to generate patterns of given size
# Usage: program -i pssm_col_file -w window_size -o outputFile
#=================================================================

use Getopt::Std;
getopts('i:w:o:');

$file1=$opt_i;
$wsize=$opt_w;
$out=$opt_o;

if ($file1 ne '' && $wsize ne '' && $out ne '') {
$n = int(($wsize -1)/2);
open(FP1,"$file1");
@arr = <FP1>;
close FP1;
open (OUT,">$out");

#$null="0 0 0";  ##   Program exactly same as gpsr/bin/pssm2pat' except only 3 zeros instead of 20,Due to only 3 values is DSSP matrix instaed of 20 in PSSM

$null="0"; 	## For one amino acid residue 1 value ie C/H/E, Comment if need 3 values for one amino acid residue

open(TEMP,">temp");
for (my $c=1;$c<=$n;$c++) { print TEMP "$null\n"; }
foreach (@arr) {my @val=split",",$_; shift @val; $val=join"",@val; $val =~ s/^\s|  //g; $val =~ s/  / /g; print TEMP "$val"; }
for (my $c=1;$c<=$n;$c++) { print TEMP "$null\n"; }
close TEMP;

open (TEMP,"temp");
@matrix=<TEMP>; close TEMP;
system "rm temp";
$len=scalar @matrix;
$st=$len-$n;

print OUT "\# Pattern Window size $wsize generated from PSSM matrix. Each line represents pattern for central residue\n";
for ($pos=$n;$pos<$st;$pos++)
{
$newmat=();
$start=$pos-$n;
$end=$pos+$n;
@newmat=@matrix[$start..$end];
my $newarr=join " ",@newmat;  $newarr =~ s/\n//g;  $newarr =~ s/ /,/g;
print OUT "$newarr\n";

}
close OUT;

}else{
    print "Usage: perl pssm2pat -i pssm_col_file -w window_size -o outputFile\n";
    print "-i\tPSSM matrix file (in column format)\n-w\tWindow size (ODD VALUE to make a central residue) to extract from the matrix file\n-o\tResult file\n";
}

# Developed by G P S Raghava on 10 Jan 2009
