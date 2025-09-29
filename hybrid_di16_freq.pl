#!/usr/bin/perl
$file1=$ARGV[0];
$file2=$ARGV[1];
open(MAK,"$file1");
open(JAK,">$file2");

while($line=<MAK>){
    chomp($line);
    $seq="acgt";
    @nt=split(//,$seq);
    @ab=split(/ /,$line);
    $len=length($ab[1]);
    $len1=$len-1;
    $len2=$len-2;
    $len3=$len-3;
    $len4=$len-4;
    print JAK $ab[0]." ";
######################### monont ######
    for($a=0;$a<$len;$a++){
	$sub=substr($ab[1],$a,1);
	$aa[$j]=$sub;
	$j++;
    }
    $n=0;
    @aa="";
    $j=0;
############################ dint #####
    for($a=0;$a<$len1;$a++)
    {
	$sub=substr($ab[1],$a,2);
	$aa[$j]=$sub;
	$j++;
    }
    ###$n=0;

    ###print JAK"$ab[0]";
    for($c=0;$c<@nt;$c++)
    {
	$b=$nt[$c];
	for($d=0;$d<@nt;$d++)
	{
	    $k=$nt[$d];
	    $join=$b.$k;
	    $n++;
	    print JAK" $n:";
	    $count=0;
	    
	    for($h=0;$h<@aa;$h++)
	    {
		if($join eq $aa[$h])
		{
		    $count++;		       
		}
	    }
	    ###$dicomp=$count/$len1;
	    $dicomp=$count;
	    printf JAK"%1.0f",$dicomp;	
	}
    }
    ###print JAK"\n";
    @aa="";
    $j=0;
    print JAK"\n";

}

