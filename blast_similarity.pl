#############################################################################
##    'blast_similarity' is free software: you can redistribute it and/or modify      #
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
#
## Orginally developed at Raghava's group <http://www.imtech.res.in/raghava/>#  
#
##############################################################################

use Getopt::Std;
getopts('i:o:d:j:e:');

$file=$opt_i;
$file2=$opt_o;
$data=$opt_d;
$j=$opt_j;
$e=$opt_e;



if ($file ne '' && $data ne '' && $file2 ne '' && $j ne '' && $e ne '' ){
system "perl $gpsr_home/bin/fasta2sfasta -i $file -o temp.sfasta";
    
 open (MAD,"temp.sfasta");
 while($line=<MAD>) 
 {


    chomp($line);
    $y=0;
    @dd=split(/\#\#/,$line);
    $dd[0]=~s/\ +//g;
    open(MAK,">Temp");
    print MAK"$dd[0]\n";
    print MAK"$dd[1]\n";

    close MAK;




    system "$gpsr_blastpgp -e $e -j $j -d $data -i Temp -o Test.out";

    open(MA,"Test.out");
    while($lin=<MA>){
        chomp($lin);
        if(($lin=~ /significant/) && ($lin=~ /alignments:/)){
            $lin=<MA>;
            $lin=<MA>;
            if($y>0){
                $lin=<MA>;
  	            }
            $y++;
            chomp($lin);
	    @ff=split(/  +/,$lin);
        						    }
    		    }
    if($y==0){
        $ff[0]="Zero";
        $ff[2]="Zero";

             }
    open(MAP,">>$file2");
    print MAP"$dd[0]\t $ff[0]\t $ff[2]\n";
    close MAP;

		}

close MAD;
system "rm Temp Test.out temp.sfasta";

}
else{
print "Usage: blast_similarity -i Seq_file(fasta) -d datbase -o output_file_name -j j_value -e e_value\n";
    } 

