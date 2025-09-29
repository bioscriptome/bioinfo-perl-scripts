#############################################################################
##    'motif2bin' is free software: you can redistribute it and/or modify    #
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
##                                                                           #
# Program to make binary input from the motif file (may or not 		     #
# conatin >header line) of FIXED LENGTH into column format 		     #
##############################################################################

use Getopt::Std;
getopts('i:x:o:');

$file=$opt_i;
$mode=$opt_x;
$bin=$opt_o;

if ($file ne '' && $bin ne '' && $mode ne '') {
open(OF,">$bin");
if ($mode =~ /y|yes/i) { @amino=qw(A C D E F G H I K L M N P Q R S T V W Y X); }
else		       { @amino=qw(A C D E F G H I K L M N P Q R S T V W Y);   }
open (FH,"$file");
while ($line=<FH>)
{
chomp $line;
if ($line !~ />/)  ## Program ignores all lines containing '>' header ie in result file will ignore '>' to make binary
 {
@seq=split "",$line;
$len=@seq;
@val=();
  for ($x=0;$x<$len;$x++)
   {
    foreach (@amino)
     { 
	if ($seq[$x] =~ /$_/) { push (@val,1); } else {push (@val,0); }
     }
   }
$join=join", ",@val;
print OF "$join";
print OF "\n";
}
}
close OF;
		}
else 
{
print "Program to make binary input from the motif file of FIXED LENGTH into column format\n";
print "Usage:perl motif2bin -i input_motifFile -x 'X' extension -o output_file\n";
print "-i\tInputFile (FIXED Length Motif file)\n-x\t[y|n]\t'y' if motif contains extra 'X' amino acid or 'n' if not.\n-o\tOutput File (in binary column format)\n";
}
