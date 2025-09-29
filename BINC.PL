#!/usr/bin/perl
#transpose of 3*3 matrix
print "given matrix\n";
@m=([A1,A2,A3],[B1,B2,B3],[C1,C2,C3]);
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
	#print "$t[$l][$k]\t";
}
	#print "\n\n";
}	
for ($o=0;$o<3;$o++)
{
for ($p=0;$p<3;$p++)
{
	print "$t[$o][$p]\t";
}
print "\n";
}



