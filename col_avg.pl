#############################################################################
##    'col_avg' is free software: you can redistribute it and/or modify      #
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
# program average columns of number of files  all files should have equal number of columns and rows
# Usage: col_avg -a col_file1 -b col_file2 -o outputFile
#=================================================================

use Getopt::Std;
getopts('a:b:o:');

$file1=$opt_a;
$file2=$opt_b;
$out=$opt_o;


if ($file1 ne '' && $file2 ne '' && $out ne ''){
	open (OUT,">$out");
	open(FP1,"$file1");
	open(FP2,"$file2");
	@arr1 = <FP1>;
	@arr2 = <FP2>;
	close FP1;
	close FP2;
    $k1 = @arr1;
    for($i2 = 0; $i2 <= $k1; $i2++){

	if(index($arr1[$i2],"#") <= -1){
	@ti1 = split(",",$arr1[$i2]);
	@ti2 = split(",",$arr2[$i2]);
	$k2 = $#ti1;
	for($i3 = 0; $i3 <= $k2; $i3++) {
	    $avg = ($ti1[$i3] + $ti2[$i3])/2;
	    if($i3 >= $k2){print OUT "$avg \n";}else{print OUT "$avg, ";}
					}
				       }
    				       }
close OUT;
}else{
    print "program average columns of number of files  all files should have equal number of columns and rows\n";
    print "Usage: col_avg -a col_file1 -b col_file2 -o outputFile\n";
}

# Developed by G P S Raghava on 10 Jan 2009
