#!/usr/bin/perl
##to generate mono nucleotide composition##
$file1=$ARGV[0];
$file2=$ARGV[1];
open(JAK,">$file2");

open(MAK,"$file1");
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

######################### monont ######
    for($a=0;$a<$len;$a++){
	$sub=substr($ab[1],$a,1);
	$aa[$j]=$sub;
	$j++;
    }
    $n=0;
#    open(JAK,">>$file2");
    print JAK"$ab[0]";
    for($c=0;$c<@nt;$c++)
    {
	$b=$nt[$c];
	    $n++;
	    print JAK" $n:";
	    $count=0;
	    
	    for($h=0;$h<@aa;$h++)
	    {
		if($b eq $aa[$h])
		{
		    $count++;		       
		}
	    }
	    ###$monocomp=$count/$len;
	    $monocomp=$count;
	    printf JAK"%1.0f",$monocomp;	
    }
    #print JAK"\n";
    @aa="";
    $j=0;
########################### pentant ########

    for($a=0;$a<$len4;$a++){
	$sub=substr($ab[1],$a,5);
	$aa[$j]=$sub;
	$j++;
    }
    #$n=0;
 #   open(JAK,">>$file2");
    #print JAK"$ab[0] ";
    for($c=0;$c<@nt;$c++){
	$b=$nt[$c];
	for($m=0;$m<@nt;$m++){
	    $l=$nt[$m];
	    for($d=0;$d<@nt;$d++){
		$k=$nt[$d];
		for($e=0;$e<@nt;$e++){
		    $s=$nt[$e];
		    for($y=0;$y<@nt;$y++){
			$z=$nt[$y];

			$join=$b.$l.$k.$s.$z;
			$n++;
			print JAK" $n:";
			$count=0;
		    
			for($h=0;$h<@aa;$h++){
			    if($join eq $aa[$h]){
			    $count++;		       
			}
			}
			$pentacomp=$count;
			printf JAK"%1.0f",$pentacomp;	
		    }   
		}
	    }
	}
    }
    print JAK"\n";
    @aa="";
    $j=0;

   # close JAK;
}

