#############################################################################
##    'domain_nppred' is free software: you can redistribute it and/or modify      #
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
## by Manish Kumar, GPS raghava                                              #
##############################################################################
#DETERMINE THE CLASS (MITOCHONDRIAL, NON-MITOHONDRIAL  & SHARED) TO WHICH DOMAIN SEARCHED BY parse_result_hmm.pl BELONGS 

$dir=$ARGV[0];
$mito=$non_mito=$common=0;

open(FH,"$dir/temp_hmm_parse_result");

while($line=<FH>)
{
    chomp($line);
    if($line =~ m/no_hit_found/)
    {
	print "no_mitochondrial_domain_found\n";
	exit;
    }


    else
    {
	print "$line";

	open(FH1,"$gpsr_home/blast_data/nppred/domain.dat") or die "$!";

	while($dom=<FH1>)
	{
	    chomp($dom);
	    #print "$dom";
	    @temp=split/:/,$dom;
	    if($temp[0] eq $line)
	    {
		#print "\t$dom\n";
		if($temp[1] eq 'm')
		{
		    print "(m) ";
		    $mito++;
		}
		elsif($temp[1] eq 'n')
		{
		    print "(n) ";
		    $non_mito++;
		}
		elsif($temp[1] eq 'c')
		{
		    print "(c) ";
		    $common++;
		}
	    }
	}
	#if(($non_mito == 0) && ($mito == 0) && ($common == 0))
	#{
	#    print "domain_not_present\n";
	#}
    }
}

print "\n";
if(($mito>0)||(($non_mito == 0)&&($common =>0)))
{
    print "result:mito\n";
}

elsif(($non_mito>0)||(($mito == 0)&&($common =>0)))
{
    print "result:non_mito\n";

}
elsif(($non_mito == 0) && ($mito == 0) && ($common >0))
{
    print "result:both\n";
}
else
#elsif(($non_mito == 0) && ($mito == 0) && ($common == 0))
{
    print "result:non_curated\n";
}
