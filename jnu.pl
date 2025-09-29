#!/usr/bin/perl
#transpose of 3*3 matrix
#print "given matrix\n";
@m=([1,1,1],[1,1,1],[1,1,1]);
for ($i=0;$i<3;$i++)
{
for ($j=0;$j<3;$j++)
{
print "$m[i][j]\t"}
print"\n"}	
for ($k=0;$k<3;$k++)
{
for ($l=0;$l<3;$l++)
{
if	{$m[$k][$l]=$m[$l][$k];
print "s\n";
}else{ print "ns\n";}
}
}
