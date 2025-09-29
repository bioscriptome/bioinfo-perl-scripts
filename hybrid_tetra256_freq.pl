#!/usr/bin/perl
##to generate mono nucleotide composition##
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
    @aa="";
    $j=0;
########################### tetrant #########
    for($a=0;$a<$len3;$a++){
	$sub=substr($ab[1],$a,4);
	$aa[$j]=$sub;
	$j++;
    }
$n=0;
    ###print JAK"$ab[0] ";
    for($c=0;$c<@nt;$c++){
	$b=$nt[$c];
	for($m=0;$m<@nt;$m++){
	    $l=$nt[$m];
	    for($d=0;$d<@nt;$d++){
		$k=$nt[$d];
		for($e=0;$e<@nt;$e++){
		    $s=$nt[$e];
		    $join=$b.$l.$k.$s;
		    $n++;
		    print JAK" $n:";
		    $count=0;
		    
		    for($h=0;$h<@aa;$h++){
			if($join eq $aa[$h]){
			    $count++;		       
			}
		    }
		    ###$tetracomp=($count/($len3));
		    $tetracomp=$count;
		    printf JAK"%1d",$tetracomp;	
		}   
	    }
	}
    }

    print JAK"\n";
    @aa="";
    $j=0;

}

