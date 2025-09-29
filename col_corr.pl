#############################################################################
##    'col_corr' is free software: you can redistribute it and/or modify      #
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

# Program for correlation coefficeint. Usage: col_corr -i file -a col1 -b col2

use Getopt::Std;
getopts('i:a:b:');

$file1=$opt_i;
$col1=$opt_a;
$col2=$opt_b;

if($file1 ne '' && $col1 ne '' && $col2 ne ''){
open(FP1,"$file1");
$ar1 = 0;
while($t1=<FP1>){
    chomp($t1);
if(index($t1,"#") <= -1){ 
    $ar1++;
    @ti = split(",",$t1);
    $x[$ar1] = $ti[$col1];
    $y[$ar1] = $ti[$col2];
}
}
close FP1;


$sx = 0;
$sy = 0;
$sxx = 0;
$syy = 0;
$sxy = 0;


for($i1=1; $i1<= $ar1; $i1++){

    $sx = $sx + $x[$i1];
    $sy = $sy + $y[$i1];
    $sxx = $sxx + $x[$i1]* $x[$i1];
    $sxy = $sxy + $x[$i1]* $y[$i1];
    $syy = $syy + $y[$i1]* $y[$i1];

}


$num = $sxy - ($sx*$sy)/$ar1;

$den = sqrt(($sxx - ($sx*$sx)/$ar1)*($syy - ($sy*$sy)/$ar1));

$cor = $num/$den;

printf("%-6.3f\n",$cor);
}
else
{
print "Program for correlation coefficeint.\n";
print "Usage: col_corr -i col_file -a col_num1 -b col_num2 \n"; 
}
