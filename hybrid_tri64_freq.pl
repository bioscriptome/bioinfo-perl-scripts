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

    $n=0;
    print JAK"$ab[0]";
  

########################### trint #########

    for($a=0;$a<$len2;$a++){
	$sub=substr($ab[1],$a,3);
	$aa[$j]=$sub;
	$j++;
    }
    ###$n=0;
#    open(JAK,">>$file2");
    ###print JAK"$ab[0]";
    for($c=0;$c<@nt;$c++){
	$b=$nt[$c];
	for($m=0;$m<@nt;$m++){
	    $l=$nt[$m];
	    for($d=0;$d<@nt;$d++){
		$k=$nt[$d];
		$join=$b.$l.$k;
		$n++;
		print JAK" $n:";
		$count=0;
	    print "$join,";
	    for($h=0;$h<@aa;$h++){
		if($join eq $aa[$h]){
		    $count++;      
		}
	    }
	    ###$tricomp=$count/$len2;
	    $tricomp=$count;
	    printf JAK"%1.0f",$tricomp;
	    	}
    }
    }
    print JAK"\n";
    @aa="";
    $j=0;

   # close JAK;
}

