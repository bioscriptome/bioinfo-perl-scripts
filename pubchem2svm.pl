#!/usr/bin/perl
open(FP,"$ARGV[0]");
while($line=<FP>)
{
chomp($line);
if($line !~/PubChem/)
{
@a=split"\t",$line;
print "0 ";
for($i=1;$i<@a;$i++)
{
print "$i:$a[$i] ";
}
print "\n";
}
}
