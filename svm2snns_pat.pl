#!/usr/bin/perl

$file=$ARGV[0];

$cl=0;
open(FP1,"$file");
while($line=<FP1>){
chomp($line);
$cl++;
}
close FP1;


print "SNNS pattern definition file V4.2\n";
print "generated at MON May 12 11:11:50 2008\n\n\n";
print "No. of patterns : $cl\n";
print "No. of input units : 357\n";
print "No. of output units : 1 \n\n";
$c=0;

open(FP,"$file");
while($line=<FP>){
@seq=""; 
 chomp($line);
$c++;
   	@A=split(/\s+/,$line);

$b=$c+0;
print '# Input Pattern: '."$b\n";


for($a=1;$a<=$#A;$a++)
{
    @temp=split(/:/,$A[$a]);
    print "$temp[1] ";
}
print "\n";
print '# Output Pattern: '."$b\n";


#$phi=($A[0]+180)/540;

#$phi=sprintf("%7.4f",$phi);
#$phi=~s/\ +//g;

#$psi=($A[1]+180)/540;
#$psi=sprintf("%7.4f",$psi);
#$psi=~s/\ +//g;


print "$A[0]";

print "\n";
}

 
