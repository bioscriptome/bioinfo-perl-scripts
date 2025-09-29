#############################################################################
##    'col_mult_sel' is free software: you can redistribute it and/or modify      #
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
# program developed for multiplying selective columns with a number
# Usage: program -i col_file -o svm_outfile -n number -a from_col_no -b tocol_no
# Usage: program -i col_file -n number -a from_col_no -b tocol_no
#=================================================================

use Getopt::Std;
getopts('i:o:n:a:b:');

$file1=$opt_i;
$file2=$opt_o;
$num=$opt_n;
$cnum1=$opt_a;
$cnum2=$opt_b;

if ($file1 ne '' && $file2 ne '' && $num ne '' && $cnum1 ne '' && $cnum2 ne ''){

open(FP1,"$file1");
open(FP2,">$file2");
while($t1=<FP1>){
    chomp($t1);
    if(index($t1,"#") != 0){
    @ti = split(",",$t1);
$count = 0;
    $count1 = $#ti;
    foreach(@ti){
	$c2 = $_;
	$count++;
	if(($count >= $cnum1) && ($count <= $cnum2)){$c2 = $c2*$num;}
            if($count <= $count1){printf(FP2 "%-f,",$c2);}else{printf(FP2 "%-f ",$c2);}	
    }
    print FP2 "\n";
}
}
close FP1;
close FP2;

}elsif($file1 ne '' && $num ne '' && $cnum1 ne '' && $cnum2 ne ''){
open(FP1,"$file1");
while($t1=<FP1>){
    chomp($t1);
    if(index($t1,"#") != 0){
    @ti = split(",",$t1);
    $count1 = $#ti;
$count = 0;
    foreach(@ti){
	$c2 = $_;
	$count++;
	if(($count >= $cnum1) && ($count <= $cnum2)){$c2 = $c2*$num;}
            if($count <= $count1){printf("%-f,",$c2);}else{printf("%-f ",$c2);}

    }
    print "\n";
}
}
close FP1;

}else{
    print "Usage: col_mult_sel -i col_file -o col_output -n number -a from_col_no -b tocol_no\n";
    print "Usage for displaying on screen: col_mult_sel -i col_file -n number -a from_col_no -b tocol_no\n";
}

# Developed by G P S Raghava on 31 Jan 2009
