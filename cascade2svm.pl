#!/usr/bin/perl
open(FP,"$ARGV[0]");
while($line=<FP>)
{
chomp($line);
@a=split"\t",$line;
print "0 ";
for($i=0;$i<@a;$i++)
{
$count=$i+1;
print "$count:$a[$i] ";
}
print "\n";
}
