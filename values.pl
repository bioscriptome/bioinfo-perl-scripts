#!/usr/bin/perl 

$file=$ARGV[0];


open(FP,"$file");
while($line=<FP>){

chomp($line);

   	
@A=split(/\s+/,$line);
$len=@A;

if ($A[0] !~ /#/ && $len==1){
    print "@A,";
    
}
if($line =~ /#/){
    print "\n";
}
}
