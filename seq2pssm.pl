#############################################################################
###    'seq2pssm' is free software: you can redistribute it and/or modify      #
###    it under the terms of the GNU General Public License as published by   #
###    the Free Software Foundation, either version 3 of the License, or      #
###    (at your option) any later version.                                    #
###############################################################################
###    This program is distributed in the hope that it will be useful,        #
###    but WITHOUT ANY WARRANTY; without even the implied warranty of         #
###    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the          #
###    GNU General Public License for more details.                           #
###                                                                           #
###    You should have received a copy of the GNU General Public License      #
###    along with this program.  If not, see <http://www.gnu.org/licenses/>.  #
###############################################################################
### Orginally developed at Raghava's group <http://www.imtech.res.in/raghava/>#  
#=================================================================
# Program for computing PSSM matrix in column format without any normalization
#This program put values corresponing to each amino acid in order "ACDEFGHIKLMNPQRSTVWY"
# Usage: program -i sfile -o ofile -d database
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
        if ($line =~ /^>/) { $line =~ s/\s+/_/g; $name=substr($line,1,12); }
        }
        close IN;

$res = `$gpsr_blastpgp -d $dbase -i $file1 -j 3 -h 0.001 -Q $name.tmp`;
open(FP1, "$name.tmp");
open(FP2, ">$file2");
$count = 0;
    while($t1=<FP1>){
	chomp ($t1);
	if(index($t1, "A  R  N  D  C  Q") >= 0){$count = 23; $t1=<FP1>;}
	    $len1 = length($t1);
	if(($count >= 1) && ($len1 >= 100)){
	    @ti = split(" ",$t1);
#	    print "$t1\n";

	    print FP2 "$ti[1], $ti[2], $ti[6], $ti[5], $ti[8], $ti[15], $ti[9], $ti[10], $ti[11], $ti[13], $ti[12], $ti[14], $ti[4], $ti[16], $ti[7], $ti[3], $ti[17], $ti[18], $ti[21], $ti[19], $ti[20] \n";
	}
    }
close(FP1);
close(FP2);
system "rm $name.tmp";
}else{
    print "Program for computing PSSM matrix by 'Blastpgp -Q' method\n";
    print "Usage:perl seq2pssm -i fasta_file -o output_file -d database\n";
print "-i\tInput File (single sequence in Fasta format)\n-o\tOutput Result File (in PSSM column format) \n-d\tDatabase against which want to create PSSM  matrix\n";
}

# Developed by G P S Raghava on 31 Jan 2009
