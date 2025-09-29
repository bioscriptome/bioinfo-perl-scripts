#############################################################################
##    'col_add' is free software: you can redistribute it and/or modify      #
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
# program add colmns of two files  
# Usage: program -i col_file1 -c col_file2 -o output_file
# Usage: program -i col_file1 -c col_file2 
#=================================================================

use Getopt::Std;
getopts('i:c:o:');
$file1=$opt_i;
$file2=$opt_c;
$file3=$opt_o;

#--------------------------------------------------------------
if(($opt_i eq '')||($opt_c eq ''))
{
    print "-i\tGive column file for add\n";
    print "-c\tGive second column file for add\n";
    print "-o\tGive the output file name\n";
    print "Usage: add_col -i col_file1 -c col_file2 -o output_file\n";
    print "Usage for displaying on screen: addcol -i col_file1 -c col_file2\n";
    exit();
}
#===================================================================
if(($opt_i ne '')&& ($opt_c ne '') && ($opt_o ne '')){
open(FP1,"$file1");
open(FP2,"$file2");
open(FP3,">$file3");
while($t1=<FP1>){
    $t2=<FP2>;
    chomp($t1);
    chomp($t2);
    print FP3 "$t1 $t2\n";
}
close FP1;
close FP2;
close FP3;
exit();
}
if(($opt_i ne '') && ($opt_c ne '')){
open(FP1,"$file1");
open(FP2,"$file2");
while($t1=<FP1>){
    $t2=<FP2>;
    chomp($t1);
    chomp($t2);
    print "$t1 $t2\n";
}
close FP1;
close FP2;
exit();
}
# Developed by G P S Raghava on 10 Jan 2009
