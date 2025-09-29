##############################################################################
####    'nuc2nac_5end' is free software: you can redistribute it and/or modify #
####    it under the terms of the GNU General Public License as published by   #
####    the Free Software Foundation, either version 3 of the License, or      #
####    (at your option) any later version.                                    #
################################################################################
####    This program is distributed in the hope that it will be useful,        #
####    but WITHOUT ANY WARRANTY; without even the implied warranty of         #
####    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the          #
####    GNU General Public License for more details.                           #
####                                                                           #
####    You should have received a copy of the GNU General Public License      #
####    along with this program.  If not, see <http://www.gnu.org/licenses/>.  #
################################################################################
#### Orginally developed at Raghava's group <http://www.imtech.res.in/raghava/>#  
#### by Firoz Ahmed, GPS Raghava                                               #
#=================================================================
# program developed for computing nucleic acid composition of
# 5-end terminal of a DNA/RNA.  
# Usage: program nuc_sfata(single line fasta) outfile 5'-end-length
# Usage: program nuc_sfata(single line fasta)     5'-end-length
#=================================================================

use Getopt::Std;
getopts('i:o:n:');
$file1=$opt_i;
$file2=$opt_o;
$nt=$opt_n;
$aa = "#ACGT";

if (($opt_i eq '')&&($opt_o eq '')||($opt_n eq ''))
{
    print "USAGE: nuc2nac -i <input file> -o <outfput file> -n <5-end position>\n";
    print "Input sequence in single fasta format\n";
    exit();
}
if (($opt_i ne '')&&($opt_o ne '')&&($opt_n ne ''))
{
open(FP1,"$file1");
open(FP2,">$file2");
print FP2 "# Nucleic Acid Composition of $nt 5'-end of DNA/RNA \n";
print FP2 "# A , C , G, T/U, \n";
while($t1=<FP1>){
    chomp($t1);
    uc($t1);
 $c1 = substr($t1,0,1);
    if($c1 =~ ">")
{
    @ti = split("##",$t1);
    $ti[1]=~tr/ACGTU/ACGTT/;
    @ti1 = split("",$ti[1]);	    
    $len = length ($ti[1]);
    for($i1=1; $i1 <= 4; $i1++){$comp[$i1]=0;}
    $count = 0;
    foreach(@ti1){
	$c2 = $_;
	$in1 = index($aa,$c2);
	$count++;
	if($count <= ($nt)){$comp[$in1]++;}
    }
    for($i1=1; $i1 <= 4; $i1++){
        $perc = ($comp[$i1]*100)/$nt;
        printf(FP2 "%5.2f,",$perc);
    }
    print FP2 "\n";
}

}
close FP1;
close FP2;

}
if (($opt_i ne '')&&($opt_o eq '')&&($opt_n ne ''))
{
    print "# Nucleic Acid Composition of $nt 5'-end of DNA/RNA \n";
    print "# A , C , G , T/U, \n";
    
    open(FP1,"$file1");
    while($t1=<FP1>){
	chomp($t1);
	uc($t1);
	
	$c1 = substr($t1,0,1);
	if($c1 =~ ">")
	{
	    @ti = split("##",$t1);
	    $ti[1]=~tr/ACGTU/ACGTT/;
	    @ti1 = split("",$ti[1]);	    
	    $len = length ($ti[1]);
	    for($i1=1; $i1 <= 4; $i1++){$comp[$i1]=0;}
	    $count = 0 ;
	    foreach(@ti1){
		$c2 = $_;
		$in1 = index($aa,$c2);
		$count++;
		if($count <= ($nt)){$comp[$in1]++;}
		
	    }
	    for($i1=1; $i1 <= 4; $i1++){
		$perc = ($comp[$i1]*100)/$nt;
		printf("%5.2f,",$perc);
	    }
	    print "\n";
	}
	
    }
} 
   close FP1;
    



# Developed by G P S Raghava on 10 Jan 2009
