#############################################################################
###    'pssm_n4' is free software: you can redistribute it and/or modify      #
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
##=================================================================
## program is developed to normalize pssm profile ( = 1/(1+e-x)
## Usage: program pssm_col_file outputFile
#=================================================================
# program is developed to normalize pssm profile ( = 1/(1+e-(x/100))
# Usage: program pssm_col_file 
#=================================================================

use Getopt::Std;
getopts('i:o:');

$file1=$opt_i;
$out=$opt_o;

$aa = "#ACDEFGHIKLMNPQRSTVWY";
if ($file1 ne '' && $out ne '') {
open(FP1,"$file1");
open (OUT,">$out");
$count = 0;
while($t1=<FP1>){
    chomp($t1);
    if(length($t1) >= 20){
    @arr1 = split(",",$t1) ;
    print OUT "$arr1[0]";
    for($i2=1; $i2 <= 20; $i2++){
	$abc = (1/(1+exp(-$arr1[$i2]/100)));
	print OUT ", $abc";
    }

}
print OUT "\n";
}
close FP1;
close OUT;

}else{
    print "Usage: pssm_n1 pssm_col_file\n";
    print "-i\tInput PSSM matrix file (in column format)\n-o\tOutputFile (normalized valued based on '1/(1+e-(x/100)' formula)\n";
}

# Developed by G P S Raghava on 10 Jan 2009
