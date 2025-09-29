#############################################################################
##    'pred_class' is free software: you can redistribute it and/or modify   #
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
# program developed for predicting a class of protein from multiple SVM output file
# Usage: program prot_sfata(single line fasta) svm_outfile1 svm_outfile2 ..  threshold 
#=================================================================

$numb = $#ARGV;
if($numb >= 4){
$file1 = $ARGV[0];
$thr = $ARGV[$numb];

$count = 0;
    open(FP,"$file1");
    while($t1=<FP>){
	chomp($t1);
	if(index($t1,"##") >= 0){
	@ti = split("##",$t1);
	$count++;
	$arr[$count][0] = $ti[0];
	$count1 = $count;
    }
    }
    close(FP);
print "$count1 $count \n";

for($i1 = 1; $i1 < $numb; $i1++){
    $tfile = $ARGV[$i1];
    print "$tfile $count \n";
    $count = 0;
    open(FP,"$tfile");
    while($t1=<FP>){
	$count++;
	chomp($t1);
	$arr[$count][$i1] = $t1;
    }
    close(FP);
}
print "$count1 ## $numb \n";
for($i1 = 1; $i1 <= $count1; $i1++){
    $t2 = 0;
    $thr1 = $thr;
    for($i2 = 1; $i2 < $numb; $i2++){
       if($arr[$i1][$i2] >= $thr1){$t2 = $i2; $thr1 = $arr[$i1][$i2]; } 
    }
if($t2 >= 1){print "$arr[$i1][0] ## $ARGV[$t2]\n";}else{print "$arr[$i1][0] ## none \n";}
}


}else{
    print "Usage: pred_class prot_sfata(single line fasta) svm_outfile1 svm_outfile2 .. threshold\n";
}

# Developed by G P S Raghava on 31st Jan 2009
