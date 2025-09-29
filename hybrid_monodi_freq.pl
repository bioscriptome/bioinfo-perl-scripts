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
	    $monocomp=$count;
	    printf JAK"%1.0f",$monocomp;	
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
	    $dicomp=$count;
	    printf JAK"%1.0f",$dicomp;	
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
	    $tricomp=$count;
	    printf JAK"%1.0f",$tricomp;	
	}
    }
    }
    ###print JAK"\n";
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


