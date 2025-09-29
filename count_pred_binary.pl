#############################################################################
##    'count_pred_binary' is free software: you can redistribute it and/or modify      #
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
#
# Program counts no of positive predicted hits in svm result file and trace 
# back motif by reading motif file					     #
###############################################################################

use Getopt::Std;
getopts('p:s:m:o:t:a:');

$file1=$opt_p;
$seq=$opt_s;
$file2=$opt_m;
$file3=$opt_o;
$thr=$opt_t;
$append=$opt_a;  ## Just to print N or C terminal on the Result file

if (-e $file1) {

open (FH2,"$file2");
@motif=<FH2>;close FH2;
open (FH3,">>$file3");
open (SEQ, "$seq"); @seq=<SEQ>; close SEQ;
$seqs=join"",@seq; $seqs =~ /\#\#(.+)/; $seqs=$1;
#print "$seqs";
$count_line=0;
$count_pos =0;
open (FH,"$file1");
print FH3 "$motif[0]";  # Containing header line of each query sequence
print FH3 "------------------------------------------------\n";
print FH3 " MOTIF  			  Score   \tPosition ($append) \n";
print FH3 "------------------------------------------------\n";
while ($line=<FH>)      # Reading SVM classify file values one-by-one
{
  $count_line++;
  chomp $line;
  $mot=$motif[$count_line];
  chomp $mot;
# if ($line !~ /-/)           # Mentioning Zero thresold
  if ($line >= $thresold)     # Setting user defined thresold
   { 
    $position =0;
    $count_pos++; 
    $position=index($seqs,$mot);$str=$position+1; $end=$str+15; 
    print FH3 " $mot\t\t  $line \t $str -- $end\n";
   }
}
print FH3 "------------------------------------------------\n";
print FH3 "HITS FOUND:	$count_pos\n";
print FH3 "***********************************\n";
close FH;close FH3;
		}
else
{
print "Usage:  program -p svmScoreFile -s sequenceFile -m motifFile -o outputFile -t threshold -a append\n";
print "-p\tPrediction file (svmScoreFile after svm_classify)\n-s\tsequenceFile (simple sfasta)\n-m\tmotifFile (from which created binary)\n-o\tOutput ResultFile\n-t\tThreshold selected\n-a\tAppend tag ('N-Splice' or 'C-Splice' just to print in the result file)\n";
}

