#!/usr/bin/perl
#transpose of 3*3 matrix & check if given one is symmetric
print "given matrix\n";
@m=([1,2,3],[2,5,4],[3,4,6]);
for ($i=0;$i<3;$i++)
{
for ($j=0;$j<3;$j++)
{
	
print "$m[$i][$j]\t";

}

print "\n";
}
print "transpose\n";
@t=();
for ($k=0;$k<3;$k++)
{
for ($l=0;$l<3;$l++)
{
	$t[$k][$l]=$m[$l][$k];
	
}
	
}	
for ($o=0;$o<3;$o++)
{
for ($p=0;$p<3;$p++)
{
	print "$t[$o][$p]\t";
}
print "\n";
}

if ($m[0][1]!= $m[1][0]) {
print "n"; 
} elsif   ($m[0][2]!= $m[2][0]) 
{
	print "n";}
	elsif   ($m[1][2]!= $m[2][1]) {
print "n";}
else {print "s"

}
