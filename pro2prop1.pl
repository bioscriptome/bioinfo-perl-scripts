##############################################################################
##    'pro2prop1' is free software: you can redistribute it and/or modify    #
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
## by Arti garg, GPS Raghava
##############################################################################

use Getopt::Std;
getopts('i:m:o:');

$file=$opt_i;
$out=$opt_o;


chomp($file);
chomp($out);


if ($file ne '' && $out ne '')
{



open(FP1,">$out");




$amino="XGAVLIMPFYWSTCNQRKHED";
@cc=split(//,$amino);
print FP1  "# Amino Acid Composition of proteins \n";
print  FP1 "# A , C , D , E , F , G , H , I , K , L , M , N , P , Q , R , S , T , V , W , Y, \n";


open(FP,"$file");
while($line=<FP>){
    chomp($line);
    $c=0;
    @A=split(/\ \#\#/,$line);
    $A[1]=~ s/[\s]//g;
    @prot=split(//,$A[1]);
    $len=@prot;
    open(MAJ,"../modules/common/correct_format");
    while($li=<MAJ>){
	chomp($li);
	$c++;
	$val="";

	@value=split(/ +/,$li);
	for($p=0;$p<@prot;$p++){
	    for($a=0;$a<@cc;$a++){
		if($prot[$p] eq "$cc[$a]"){
		    $val +=$value[$a];

	    }
	}

	$val1=$val/$len;
	$d=substr($val1,0,6);
}
	if($c <= 32){
            printf(FP1 "%7.4f,",$d)}
        else
        {
            printf(FP1 "%7.4f ",$d);}
    }

	print FP1 "\n";
}
}
else
{
    print "This program computes properties based 33 input variables\n";
    print "Usage: seq2pssm_imp -i seq_file -o output_file\n";
    print "-i\tInput File (Sequences in simple fasta format)\n-o\tOutput Result File\n";
}

