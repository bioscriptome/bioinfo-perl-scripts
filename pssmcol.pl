#############################################################################
##    'pssmcol' is free software: you can redistribute it and/or modify      #
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

use Getopt::Std;
getopts('i:o:');

$file=$opt_i;
$file1=$opt_o;


#$file=$ARGV[0];

#$file1=$ARGV[1];

if ($file ne '' && $file1 ne ''){

open(FP2,">$file1");
open(MAD,"$file");
$line=<MAD>;
while($line=<MAD>){
    chomp($line);
    $line=~s/\>//g;
    @dd=split(/\ \#\#/,$line);
    $dd[0]=~s/\>//g;

    $name[$r]=$dd[0];
    $r++;
}
for ($f=0;$f<@name;$f++){
    
    print FP2 "$name[$f] ::";
    open(FP1,"$name[$f].mtx");
    while($line=<FP1>){

        chomp($line);
        if ($line=~/[A-Z]/){
            print FP2 "$line ::";
        }
        @A=split(" ",$line);
        if($A[0] eq "-32768"){
            @num=split(" ",$line);
            shift(@num);
            print FP2 "$num[0] ";
            print FP2 "$num[2] ";

            for($i1=3;$i1<21;$i1++){

            #for($i1=3;$i1<(@num-4);$i1++){
                print FP2 "$num[$i1] ";
            }
            print FP2 ";";
        }
    }
    print FP2 "\n";
}
}else{
print "\nUsage for pssmcol :perl pssmcol -i sequence_file (simple format) -o output_file\n\n";

}
