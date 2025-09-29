#############################################################################
##    'pred_thrs' is free software: you can redistribute it and/or modify      #
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
# program developed for predicting a class of protein from SVM output file
# Usage: program -i prot_sfata(single line fasta) -f svm_outfile -t threshold -s label
#=================================================================

use Getopt::Std;
getopts('i:f:t:s:');

$file1=$opt_i;
$file2=$opt_f;
$thr=$opt_t;
$label=$opt_s;


if($file1 ne '' && $file2 ne '' && $thr ne '' && $label ne ''){
open(FP1,"$file1");
open(FP2,"$file2");
while($t1=<FP1>){
    chomp($t1);
    uc($t1);
	@ti = split(/##/,$t1);
    if(index($t1,"##") >= 0){
	$t2 = <FP2>;
	chomp($t2);
	if($t2 >= $thr){print "$ti[0] ## $label ## $t2 ## $thr\n";}else{print "$ti[0] ## non-$label ## $t2 ## $thr\n";}
    }
}
close FP1;
close FP2;

}else{
    print "Usage: pred_thr -i prot_sfata(single line fasta) -f svm_outfile -t threshold -s label\n";
}

# Developed by G P S Raghava on 31st Jan 2009
