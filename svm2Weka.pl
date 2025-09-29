#!/usr/bin/perl
#perlprogram for KNN pattern##
$file1=$ARGV[0];
open(FP1,"$file1");
#open(FP2,">$file2");
while($t1=<FP1>){
    chomp($t1);
    open(FP1,"$file1");print "@"."RELATION $file1\n\n";
while($t1=<FP1>){
    chomp($t1); 
    if(index($t1,"#") != 0){
	@t2 = split(" ",$t1);
    }
}
for($i=1;$i<@t2;$i++)
{
    print "@"."ATTRIBUTE F$i REAL\n";
}
print "@"."ATTRIBUTE class\tREAL\n\n";
print "@"."DATA\n";
close FP1;
}
open(FP, "$file1");
while($line=<FP>)
{
    chomp($line);
    @aa1=split(/\s+/, $line);
    for($i=1;$i<@aa1; $i++)
    {
	@aa2=split(/:/,$aa1[$i]);
	print "$aa2[1],";
    }
    print "$aa1[0]\n";
}
