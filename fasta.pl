#!/usr/bin/perl
open(FP,"apop_negative.txt");
while($line=<FP>)
{
chomp($line);
$c++;
print ">aip-_$c\n";
print "$line\n";
}
