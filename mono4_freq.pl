#!/usr/bin/perl
##to generate mono nucleotide composition##
$file1=$ARGV[0];
$file2=$ARGV[1];
open(JAK,">$file2");

open(MAK,"$file1");
while($line=<MAK>){
    chomp($line);
#    $seq="acgt";
    @nt=split(//,$seq);
    @ab=split(/ /,$line);
    $len=length($ab[1]);
    $len1=$len-1;
    $len2=$len-2;
    $len3=$len-3;
    $len4=$len-4;
    $seq=$ab[1];                                                                                                                                           

    $j=0;
    $a=($seq=~tr/Aa//);
    $c=($seq=~tr/Cc//);
    $g=($seq=~tr/Gg//);
    $t=($seq=~tr/TtUu//);
    @array=($a,$c,$g,$t);
    print JAK"$ab[0]";
    for($a=1;$a<5;$a++){
    
	
	
	    print JAK" $a:$array[$a-1]";

    } print JAK "\n";
}
