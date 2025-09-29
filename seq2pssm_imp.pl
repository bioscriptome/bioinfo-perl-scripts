#############################################################################
##    'seq2pssm_imp' is free software: you can redistribute it and/or modify      #
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
##############################################################################
#=================================================================
# Program for computing PSSM matrix in column format without any normalization
# This program uses IMPALA makemat program
#This program put values corresponing to each amino acid in order "ACDEFGHIKLMNPQRSTVWY"
# Usage: program -i sequencefile -o ofile -d database
#=================================================================

use Getopt::Std;
getopts('i:o:d:');

$file1=$opt_i;
$file2=$opt_o;
$dbase=$opt_d;

if ($file1 ne '' && $file2 ne '' && $dbase ne '') 
    {
	open (IN ,"$file1");
	while ($line =<IN>)
	{
	if ($line =~ /^>/) { $name = substr($line,1,26); $name =~ s/\ +//g; $name =~ s/\|/\_/g; }
	}
	close IN;
chomp $name;
#print "NAME:$name:\n";
unless (-e "$name.mtx")
	{
$res = `$gpsr_blastpgp -d $dbase -i $file1 -j 3 -h 0.001 -C $name.chk`;

open(FP2, ">$name.pn");
print FP2 "$name.chk";
open(FP3, ">$name.sn");
print FP3 "$file1";
close(FP2);
close(FP3);

$res = `$gpsr_makemat -P $name`; 
system "rm $name.aux $name.chk $name.mn $name.pn $name.sn";
	}
open(FP1, "$name.mtx");
$t1 = <FP1>;
$t1 = <FP1>;
@arr = split(//,$t1);
open(FP2, ">$file2");
$count = 0;
    while($t1=<FP1>){
	chomp ($t1);
	if(index($t1, "-32768") >= 0){
@arr1 = split(" ",$t1);
print FP2 "$arr[$count], $arr1[1], $arr1[3]";
for($i1 = 4; $i1 <= 20; $i1++){  ## need to repalce 21 with 20 if need only 20 values
	 print FP2 ", $arr1[$i1]";
			      }
	 print FP2 ", $arr1[22]\n";
	 $count++;	
		    		     }

    		    }
close(FP1);
close(FP2);
#system "rm $name.aux $name.chk $name.mn $name.pn $name.sn";
	
    }
else
    {
    print "This program uses IMPALA makemat program to calculate PSSM matrix\n";
    print "Usage: seq2pssm_imp -i fasta_file -o output_file -d database\n";
    print "-i\tInput File (single sequence in Fasta format)\n-o\tOutput Result File (in PSSM column format) \n-d\tDatabase against which want to create PSSSM matrix\n";
    }

# Developed by G P S Raghava on 31 Jan 2009
