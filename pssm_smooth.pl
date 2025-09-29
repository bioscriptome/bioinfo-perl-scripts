#############################################################################
##    'pssm_smooth' is free software: you can redistribute it and/or modify  #
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
#=================================================================
# program is designed to smoth pssm profile (plot) of 
# Usage: program -i pssm_col_file -w window_size -o outputFile
#=================================================================

use Getopt::Std;
getopts('i:w:o:');

$file1=$opt_i;
$wsize=$opt_w;
$out=$opt_o;

if ($file1 ne '' && $wsize ne '' && $out ne '') {
$wsize1 = int(($wsize-1)/2);
open(FP1,"$file1");
open (OUT ,">$out");
@arr = <FP1>;
$len1 = $#arr;
$count = 0;
for($i1=0; $i1 <= $len1 ; $i1++){
  @ti1 = split(",",$arr[$i1]) ;
  print OUT "$ti1[0], ";
  for($j1 = 0; $j1 <= $#ti1; $j1++){$ti[$j1] = 0;}
for($i2=-3; $i2 <= 3 ; $i2++){
  $k1 = $i1  + $i2;
  if($k1 <= 0){$k1 = 0;}
  if($k1 >= $len1){$k1 = $len1;}
  @ti1 = split(",",$arr[$k1]) ;
  for($j2 = 0; $j2 <= $#ti1; $j2++){$ti[$j2] = $ti[$j2] + $ti1[$j2];}
}
  for($j1 = 1; $j1 <= $#ti1; $j1++){
      $ti[$j1] = $ti[$j1]/$wsize; 
      if($j1 >= $#ti1){print OUT "$ti[$j1] ";}else{print OUT "$ti[$j1], ";}
  }
  print OUT "\n";
}
close FP1; close OUT;

}else{
    print "Usage: pssm_smooth -i pssm_col_file -w window_size -o outputFile\n";
    print "-i\tPSSM column file (containing matrix values)\n-w\tWindow size \n-o\tOutputFile\n";
}

# Developed by G P S Raghava on 10 Jan 2009
