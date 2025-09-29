#############################################################################
##    'col_mult' is free software: you can redistribute it and/or modify      #
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
# program developed for multiplying each column with a number
# Usage: program -i col_file -o svm_outfile -n number
# Usage: program -i col_file -n number
#=================================================================
#=================================================================
use Getopt::Std;
getopts('i:o:n:');

$file1=$opt_i;
$file2=$opt_o;
$num=$opt_n;
#--------------------------------------------------------------
if(($opt_i eq '')||($opt_n eq ''))
{
    print "-i\tFile column separated value\n";
    print "-o\tOutput file name\n";
    print "-n\t Give the value for multiplication\n";
    print "Usage: col_mult.pl -i col_file -o output -n value\n";
    print "Usage for displaying on screen: col_mult.pl -i col_file -n value \n";
}
#=================================================================

if(($opt_i ne '')&& ($opt_o ne '') &&($opt_n ne '')){
open(FP1,"$file1");
open(FP2,">$file2");
while($t1=<FP1>){
    chomp($t1);
    if(index($t1,"#") == 0){
	print FP2 "$t1\n";
			   }
    if(index($t1,"#") != 0){
    @t1=();
    @ti = split(",",$t1);
    $count = 0;
    foreach(@ti){
	chomp $_;
	$_ =~ s/ //g;
	$c2 = $_;
	$c2 = $c2*$num;
	$count++;
	printf(FP2 "%f,",$c2);
    }
    print FP2 "\n";
}
}
close FP1;
close FP2;
exit();
}if(($opt_i ne '') &&($opt_n ne '')){
$file1 = $ARGV[0];
$num = $ARGV[1];
open(FP1,"$file1");
while($t1=<FP1>){
    chomp($t1);
    if(index($t1,"#") != 0){
    @ti = split(",",$t1);
$count = 0;
    foreach(@ti){
	$c2 = $_;
	$c2 = $c2*$num;
	$count++;
	printf("%-f,",$c2);
    }
    print "\n";
}
}
close FP1;

}

# Developed by G P S Raghava on 10 Jan 2009
