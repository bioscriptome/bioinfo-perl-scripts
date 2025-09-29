#############################################################################
##    'col_sig' is free software: you can redistribute it and/or modify      #
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
##                                                                           #
##############################################################################

#=================================================================
# program calculates significance of columns in two column files
# Usage: program -i col_file1(positive examples) -j col_file2(negative examples)
#=================================================================

use Getopt::Std;
getopts('i:j:');

$file1=$opt_i;
$file2=$opt_j;

if ($file1 ne '' && $file2 ne '') {
#====== Handling first file ==========
    	$count1 = 0;
	open(FP1,"$file1");
	@arr1 = <FP1>;
	close FP1;
	for($i1 = 0; $i1 <= 1000; $i1++){$arr3[$i1] = $arr4[$i1] = $arr5[$i1]=$arr6[$i1]=0;}
	$k1 = @arr1;
	for($i2 = 0; $i2 <= $k1; $i2++){
	    if((index($arr1[$i2],"#") <= -1) && (length($arr1[$i2]) >= 10)){
		$count1++;
		@ti1 = split(",",$arr1[$i2]);
		$k2 = $#ti1;
		for($i3 = 0; $i3 <= $k2; $i3++){$arr3[$i3] = $arr3[$i3] + $ti1[$i3];}
	    }
	}


#====== Handling second file ==========
	open(FP2,"$file2");
	@arr2 = <FP2>;
	close FP2;
	$count2 = 0;
	$k3 = @arr2;
	for($i2 = 0; $i2 <= $k1; $i2++){
	    if((index($arr2[$i2],"#") <= -1) && (length($arr2[$i2]) >= 10)){
		$count2++;
		@ti1 = split(",",$arr2[$i2]);
		$k2 = $#ti1;
		for($i3 = 0; $i3 <= $k2; $i3++){$arr4[$i3] = $arr4[$i3] + $ti1[$i3];}
	    }
	}


	for($i3 = 0; $i3 <= $k2; $i3++){
	    $arr3[$i3] = $arr3[$i3]/$count1;
	    $arr4[$i3] = $arr4[$i3]/$count2;
	}


#====== Handling first file ==========
	for($i2 = 0; $i2 <= $k1; $i2++){
	    if((index($arr1[$i2],"#") <= -1) && (length($arr1[$i2]) >= 10)){
		@ti1 = split(",",$arr1[$i2]);
		$k2 = $#ti1;
		for($i3 = 0; $i3 <= $k2; $i3++){$arr5[$i3] = $aar5[$i3] + ($ti1[$i3] - $arr3[$i3])*($ti1[$i3] - $arr3[$i3]);}
	    }
	}


#====== Handling second file ==========
	open(FP2,"$file2");
	@arr2 = <FP2>;
	close FP2;
    $count2 = 0;
	$k1 = @arr2;
	for($i2 = 0; $i2 <= $k1; $i2++){
	    if((index($arr2[$i2],"#") <= -1) && (length($arr2[$i2]) >= 10)){
		$count2++;
		@ti1 = split(",",$arr2[$i2]);
		$k2 = $#ti1;
		for($i3 = 0; $i3 <= $k2; $i3++){$arr6[$i3] = $aar6[$i3] + ($ti1[$i3] - $arr4[$i3])*($ti1[$i3] - $arr4[$i3]);}
	    }
	}

    print "\# Parameters Measured: \% Difference, Significance, Average1, Average2, Standard Deviation(SD1), SD2 \n";
	for($i3 = 0; $i3 <= $k2; $i3++){
	    my $col=$i3+1;
	    $arr5[$i3] = sqrt($arr5[$i3]/$count1);
	    $arr6[$i3] = sqrt($arr6[$i3]/$count2);
	    $pc = (($arr3[$i3]-$arr4[$i3])*200)/($arr3[$i3]+$arr4[$i3]);
	    $sig = (($arr3[$i3]-$arr4[$i3])*200)/($arr5[$i3]+$arr6[$i3]);
	    print "Column $col: $pc, $sig, $arr3[$i3], $arr4[$i3], $arr5[$i3], $arr6[$i3]\n";
	}




}else{
    print "Usage: col_sig -i col_file1(positive examples) -j col_file2(negative examples)\n";
}

# Developed by G P S Raghava on 10 Jan 2009
