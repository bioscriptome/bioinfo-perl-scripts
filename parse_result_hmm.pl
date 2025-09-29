#############################################################################
##    'parse_result_hmm' is free software: you can redistribute it and/or modify      #
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
## by Manish Kumar, GPS Raghava                                              #
##############################################################################

$dir =$ARGV[0]; #NAME OF DIRECTORY

open(FH,"$dir/temp_pfam") or die "$!";
while($line=<FH>)
{
    chomp($line);
    if($line =~ m/^Scores/)
    {
	$next0=<FH>;chomp($next0);
	$next1=<FH>;chomp($next1);
	$next=<FH>;chomp($next);
	while($next !~ m/^$/)
        {
	    if($next =~ m/\[no/)
	    {
		print "no_hit_found\n";
	    }
	    elsif($next !~ m/\[no/)
	    {
		@temp2=split/\s+/,$next;
		print "$temp2[0]\n";
	    }
            $next=<FH>;chomp($next);
        }
    }
}
close FH;
