##############################################################################
##    'seq2motif' is free software: you can redistribute it and/or modify    #
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
##############################################################################
# Program to create motifs by sliding window of user defined length for each seq in SINGLE-LINE SFASTA FORMAT.
# Adds additional 'X' at the end accordingly to make complete pattern
############################################################################## 


use Getopt::Std;
getopts('i:w:o:x:');

$input=$opt_i;		# Input single line sequence file  '>head\t fullSeq in one line'
$window=$opt_w;		# Input for motif length to create
$addX  =$opt_x;		# Option for Add X if -x =y then it will add X according to window size othersise motifs without X
$motif=$opt_o;		# Output file

if ($input ne '' && $window ne '' &&  $motif ne '') {

$n=int(($window-1)/2);
$add='X' x $n;

open (SEQUENCE,"$input");

open (OF1,">$motif");

while ($sequence=<SEQUENCE>)
{
$head=$seq=$sub="";
if ($sequence =~ /(>.+?)\#\#(.+)/)
 {
  $head=$1;$seq=$2;
  $seq =~ s/[\s\n]//g;
 }

print OF1 "$head\n";
if ($addX =~ /y|yes/i) {  $seq=uc($add.$seq.$add);  } 
#$seq=uc($add.$seq.$add);

      $len=length($seq);
      for ($y=0;$y<$len-($window-1);$y++)  
       {
        $sub=substr($seq,$y,$window);
        print OF1 "$sub\n";
       }

} # closing while 'SEQUENCE' loop
close SEQUENCE;
close OF1;
}
else
{
print "Program to create motifs by sliding window. GENRATE MOTIFS WITH or WITHOUT 'X' AT THE N AND C TERMINAL OF THE SEQUENCE IF NEEDED.\n";
print "Usage:perl seq2motif -i inputFile -w window size -x extension -o outputFile\n";
print "-i\tInputFile (SFASTA FORMAT)\n-w\tWindow size to create motifs\n-x\t[y|n] extension of 'X' needed or not\n-o\tOutput Motif file\n";
}


