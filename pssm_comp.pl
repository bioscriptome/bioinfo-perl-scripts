##############################################################################
##    'pssm_comp' is free software: you can redistribute it and/or modify    #
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
# program is designed to compute PSSM composition (400 points)
# Usage: program -i pssm_col_file -o outputFile
#=================================================================

use Getopt::Std;
getopts('i:o:');

$file1=$opt_i;
$out=$opt_o;

$aa = "#ACDEFGHIKLMNPQRSTVWY";
if ($file1 ne '' && $out ne '') {
for($i1=1; $i1 <= 20; $i1++){
for($i2=0; $i2 <= 20; $i2++){
$arr[$i1][$i2] = 0;
}
}
open(FP1,"$file1");
$count = 0;
while($t1=<FP1>){
    chomp($t1);
    $count++;
    if(length($t1) >= 20){
    @arr1 = split(",",$t1) ;
	$in1 = index($aa,$arr1[0]);
    $arr[$in1][0]++;
    for($i2=1; $i2 <= 20; $i2++){

$arr[$in1][$i2] = $arr[$in1][$i2] + $arr1[$i2];

}
    }
}
close FP1;
open (OUT,">>$out");
for($i1=1; $i1 <= 20; $i1++){
for($i2=1; $i2 <= 20; $i2++){
    $chk = $i1*$i2;
    #$abc = $arr[$i1][$i2]/$arr[$i1][0];
#    print "$abc\n";
#print "$arr[$i1][$i2]===$count \n";

$abc = $arr[$i1][$i2]/$count;
    
$abc1=sprintf("%7.4f" , $abc);
        $abc1=~s/\ +//g;


    if($chk <= 399) {

print OUT "$abc1, ";
}
else
{
print OUT "$abc1 ";}


}
}
print OUT "\n";

}
#close OUT;
else{
    print "Usage: pssm_comp -i pssm_col_file -o resultFile\n";
    print "-i\tInput File (PSSM matrix file in column format)\n-o\tOutputFile\n";
}
close OUT;
# Developed by G P S Raghava on 10 Jan 2009
