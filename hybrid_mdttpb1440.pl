#!/usr/bin/perl
##to generate mono nucleotide composition##
$file1=$ARGV[0];
$file2=$ARGV[1];
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
    open(JAK,">>$file2");
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
	    $monocomp=$count/$len;
	    ###$monocomp=$count;
	    printf JAK"%6.9f",$monocomp;	
    }
    ###print JAK"\n";
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
    open(JAK,">>$file2");
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
	    $dicomp=$count/$len;
	    ###$dicomp=$count;
	    printf JAK"%6.9f",$dicomp;	
	}
    }
    ###print JAK"\n";
    @aa="";
    $j=0;

########################### trint #########

    for($a=0;$a<$len2;$a++){
	$sub=substr($ab[1],$a,3);
	$aa[$j]=$sub;
	$j++;
    }
    ###$n=0;
    open(JAK,">>$file2");
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
	    
	    for($h=0;$h<@aa;$h++){
		if($join eq $aa[$h]){
		    $count++;		       
		}
	    }
	    $tricomp=$count/$len;
	    ###$tricomp=$count;
	    printf JAK"%6.9f",$tricomp;	
	}
    }
    }
    ###print JAK"\n";
    @aa="";
    $j=0;
########################### tetrant #########
    for($a=0;$a<$len3;$a++){
	$sub=substr($ab[1],$a,4);
	$aa[$j]=$sub;
	$j++;
    }
    ###$n=0;
    open(JAK,">>$file2");
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
		    $tetracomp=$count/$len;
		    ###$tetracomp=$count;
		    printf JAK"%6.9f",$tetracomp;	
		}   
	    }
	}
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
    open(JAK,">>$file2");
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
                        $pentacomp=$count/$len;
			###$pentacomp=$count;
			printf JAK"%6.9f",$pentacomp;	
		    }   
		}
	    }
	}
    }
    #print JAK"\n";
    @aa="";
    $j=0;

########################### binnt #########

    $varu="";
    $var=0;
    @ac=split(/ /,$line);
    $ac[1]=~s/\s//g;
    @aa=split(//,$ac[1]);
    #$len1=@aa;
    #print "$len1\n";
    for($c=0;$c<@aa;$c++)
    {
	if($aa[$c] eq "a")
	{
	    $var="1000";
	}
	if($aa[$c] eq "c")
	{
	    $var="0100";
	}
	if($aa[$c] eq "g")
	{
	    $var="0010";
	}
	if($aa[$c] eq "t")
	{
	    $var="0001";
	}
	$varu.="$var";
    }
    
    @ab=split(//,$varu);
    #$len=@ab;
    #print "$len\n";
    open(JAK,">>$file2");
    ###print JAK"$ac[0] ";
    ###$n=0;
    for($a=0;$a<@ab;$a++)
    {
	$n++;
	print JAK" $n:$ab[$a]";
    }
    print JAK"\n";
    close JAK;
}
###close MAK;


