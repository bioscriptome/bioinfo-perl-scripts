#############################################################################
##    'fasta2sfasta' is free software: you can redistribute it and/or modify      #
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
#=============================================================================
# Program developed for converting fasta format into sfasta format
# In sfasta format one sequence is presented in one line
# Usage: perl fasta2sfasta.pl -i fasta_file -o sfasta_file
#==================================================================

use Getopt::Std;
getopts('i:o:');

$file1=$opt_i;
$file2=$opt_o;

  
if ($file1 ne '' && $file2 ne ''){
open(FP1,"$file1");
open(FP2,">temp.out");
while($t1=<FP1>)	{
    chomp($t1);
    $c1 = substr($t1,0,1);
    $c2 = substr($t1,1,26);

    if($c1 =~ ">"){
	$c2=~s/\|/\_/g;
	$c2=~s/\ +//g;
print FP2 "\n>$c2 ##";

		  }else{print FP2 $t1;}

               	  	}
print FP2 "\n";
close(FP1);
close(FP2);

				}

elsif($file1 ne '' && $file2 eq ''){

open(FP1,"$file1");
while($t1=<FP1>){
    chomp($t1);
    $c1 = substr($t1,0,1);
    $c2 = substr($t1,1,26);
    if($c1 =~ ">"){

        $c2=~s/\|/\_/g;
	$c2=~s/\ +//g;

print "\n>$c2 ##";}else{print $t1;}
		}
print "\n";
close(FP1);
				 }else{
    print "Usage:perl fasta2sfasta -i fasta_file -o sfasta_file\n";
    print "Usage for displaying on screen:perl fasta2sfasta -i fasta_file \n";
    print "-i\t input file in fasta format\n-o\t output result file in sfasta format\n";
    exit;
}
$system=`grep '>' temp.out >$file2`;
$system=`rm temp.out`;

# Developed by G P S Raghava on 10 Jan 2009

