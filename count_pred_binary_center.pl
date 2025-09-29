#############################################################################
##    'count_pred_binary_center' is free software: you can redistribute it and/or modify      #
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
## by Hifzur Rahman Ansari, GPS Raghava                                      #

## Program counts no of positive predicted hits in svm result file and trace #
## back motif by reading motif file					     #
##############################################################################


use Getopt::Std;
getopts('p:s:o:t:');

$file1=$opt_p;
$seq=$opt_s;
#$file2=$opt_m;
$file3=$opt_o;
$thr=$opt_t;
#$append=$opt_a;  ## Just to print N or C terminal on the Result file

if (-e $file1) {

#open (FH2,"$file2");
#@motif=<FH2>;close FH2;
open (FH3,">>$file3");
open (SEQ, "$seq"); #@seq=<SEQ>; close SEQ;
$seqs=<SEQ>; close SEQ;
$seqs =~ /(>\w+?) \#\#(.+)/; $head=$1;$seqs=$2;
@seq=split"",$seqs;
$len_seq=scalar(@seq);
$count_line=0;
$count_pos =1;
print FH3 "$head\tLength = $len_seq\n";  # Containing header line of each query sequence

open (FH,"$file1"); ## Opening svm pred values

while ($score=<FH>)  ## Reading SVM classify file score one-by-one
{
chomp $score;
if ($score >= $thr)     # Setting user defined thresold
 {
 $seq[$count_line] = uc ($seq[$count_line]).'*';
 print FH3 "$seq[$count_line]";
 }
 else
 {
 $seq[$count_line] = lc ($seq[$count_line]);
 print FH3 "$seq[$count_line]";
 }
 if(($count_line !=0) && ($count_line % 99) ==0)
 {
 print FH3 "\n";
 #$count=0;
 }

$count_line++;
}
print FH3 "\n";
close FH;

$count_line=0;
open (FH,"$file1"); ## Opening svm pred values
print FH3 "\nDetail Residue wise View\n";
print FH3 "------------------------------------------------\n";
print FH3 "Pos\tResidue\t Score\t\tPrediction \n";
print FH3 "------------------------------------------------\n";

while ($score=<FH>)  ## Reading SVM classify file score one-by-one
{
chomp $score;
print FH3 "$count_pos\t$seq[$count_line]\t$score\t";
if ($score >= $thr)     # Setting user defined thresold
 {
 print FH3 "INTERACTING\n";
 }
 else
 {
 print FH3 "non-interacting\n";
 }
$count_line++;
$count_pos++;
}

print FH3 "***********************************\n";
close FH;close FH3;
		}
else
{
print "Usage:  program -p svmScoreFile -s sequenceFile -o outputFile -t threshold \n";
print "-p\tPrediction file (svmScoreFile after svm_classify)\n-s\tsequenceFile (simple sfasta)\n\n-o\tOutput ResultFile\n-t\tThreshold selected\n\n";
}

