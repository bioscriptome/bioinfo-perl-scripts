##############################################################################
##    'run_psipred' is free software: you can redistribute it and/or modify  #
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
getopts('i:');

$file=$opt_i;

if (-e "$file" || $file ne ''){

print "$gprs_home\n";
print "$file\n";

open(FP1,">runpsipred1");

print FP1 "\#\!\/bin\/tcsh\n\n";


print FP1 "set dbname \= $gpsr_dbname\n";
print FP1 "set ncbidir \= $gpsr_blastall\n";
print FP1 "set execdir = $gpsr_psi\n";
print FP1 "set datadir \= $gpsr_psidata\n";


print FP1 "set basename \= \$1:r\n";
print FP1 "set rootname \= \$basename:t\n";
print FP1 "set outname \= \$basename.chk\n";

print FP1 "\\cp -f \$1 psitmp.fasta\n";

print FP1 "\$ncbidir/blastpgp -v 5000 -b 0 -j 3 -e 0.01 -d \$dbname -i psitmp.fasta -C psitmp.chk >\& \$rootname.blast\n";

print FP1 "echo psitmp.chk > psitmp.pn\n";
print FP1 "echo psitmp.fasta > psitmp.sn\n";
print FP1 "\$ncbidir/makemat -P psitmp\n";



#print FP1 "\$execdir/psipred psitmp.mtx \$datadir/weights.dat \$datadir/weights.dat2 \$datadir/weights.dat3 \$datadir/weights.dat4 > \$rootname.ss\n";


#print FP1 "\$execdir/psipass2 \$datadir/weights_p2.dat 1 1.0 1.0 \$rootname.ss2 \$rootname.ss > \$rootname.horiz\n";

system "chmod 755 $gpsr_home/bin/runpsipred1";

open(MAD,"$file-simple");
$line=<MAD>;
while($line=<MAD>){
    chomp($line);
    $line=~s/\>//g;
    @dd=split(/\ \#\#/,$line);
    $dd[0]=~s/\>//g;
    open(MAK,">$dd[0].ent");
    print MAK"> $dd[0]\n";
    print MAK"$dd[@dd-1]\n";


close MAK;

print "$dd[0].ent\n";
system "tcsh $gpsr_home/bin/runpsipred1 $dd[0].ent";
system "mv psitmp.mtx $dd[0].mtx";
system "rm -rf psitmp* *.blast";
   
}
}else{
print "\nUsage:perl run_psipred -i sequence_file (fasta format)\n\n";

}
