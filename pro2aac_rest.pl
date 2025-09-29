#############################################################################
##    'pro2aac_rest' is free software: you can redistribute it and/or modify #
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
# program developed for computing amino acid composition of
# of a protein after removing N-terminal(nt) and C-terminal residues(ct).  
# Usage: program prot_sfata(single line fasta) outfile nt_residues $ct_residues
# Usage: program prot_sfata(single line fasta)     nt_residues $ct_residues
#=================================================================

use Getopt::Std;
getopts('i:o:n:c:');

$file1=$opt_i;
$file2=$opt_o;
$nt=$opt_n;
$ct=$opt_c;
#--------------------------------------------------------------
if(($opt_i eq '')||($opt_n eq '') || ($opt_c eq ''))
{
    print "-i\tGive S-FASTA input file name\n";
    print "-o\tOutput file name\n";
    print "-n\tGive the number for N terminal composition\n";
    print "-c\tGive the number for C terminal composition\n";
    exit();
}
#===================================================================
$aa = "#ACDEFGHIKLMNPQRSTVWY";
if(($opt_i ne '')&& ($opt_o ne '') &&($opt_n ne '') && ($opt_c ne '')){
open(FP1,"$file1");
open(FP2,">$file2");
print FP2 "# Amino Acid Composition of protein after removing $nt n-terminal and $ct c-terminal residues\n";
print FP2 "# A , C , D , E , F , G , H , I , K , L , M , N , P , Q , R , S , T , V , W , Y\n";
while($t1=<FP1>){
    chomp($t1);
    uc($t1);
 $c1 = substr($t1,0,1);
    if($c1 =~ ">")
{
    @ti = split("##",$t1);
    @ti1 = split("",$ti[1]);	    
    $len = length ($ti[1]);
    for($i1=1; $i1 <= 20; $i1++){$comp[$i1]=0;}
    $count = 0;
    foreach(@ti1){
	$c2 = $_;
	$in1 = index($aa,$c2);
	$count++;
	if(($count > $nt) && ($count < ($len - $ct + 1))){$comp[$in1]++;}
    }
for($i1=1; $i1 <= 20; $i1++){
        $perc = ($comp[$i1]*100)/($len-$nt-$ct);
        if($i1 <= 19)
		{
		    printf(FP2 "%5.3f,",$perc);
		}
		else
		{
		    printf(FP2 "%5.3f ",$perc);
		}
	}
    print FP2 "\n";
}

}
close FP1;
close FP2;
exit();
}if(($opt_i ne '') && ($opt_n ne '') && ($opt_c ne '')){
print "# Amino Acid Composition of protein after removing $nt n-terminal and $ct c-terminal residues\n";
print "# A , C , D , E , F , G , H , I , K , L , M , N , P , Q , R , S , T , V , W , Y\n";
open(FP1,"$file1");
while($t1=<FP1>){
    chomp($t1);
    uc($t1);
 $c1 = substr($t1,0,1);
    if($c1 =~ ">")
{
    @ti = split("##",$t1);
    @ti1 = split("",$ti[1]);	    
    $len = length ($ti[1]);
    $len1 = $#ti1;
    for($i1=1; $i1 <= 20; $i1++){$comp[$i1]=0;}
    $count = 0;
    foreach(@ti1){
	$c2 = $_;
	$in1 = index($aa,$c2);
	$count++;
	if(($count > $nt) && ($count < ($len - $ct))){$comp[$in1]++;}

    }
for($i1=1; $i1 <= 20; $i1++){
        $perc = ($comp[$i1]*100)/($len-$nt-$ct);
       if($i1 <= 19)
       {
	   printf( "%5.3f,",$perc);
       }
	else
	{
	    printf ("%5.3f ",$perc);
	}
    }
    print "\n";
}

}
close FP1;

}

# Developed by G P S Raghava on 10 Jan 2009
