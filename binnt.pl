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
    $n=0;

########################### binnt #########

    $varu="";
    $var=0;
    @ac=split(/ /,$line);
    $ac[1]=~s/\s//g;$ac[1]=~s/u/t/g;
    print JAK $ac[0]." ";$ac[1]=lc($ac[1]);
    @aa=split(//,$ac[1]);
    #$len1=@aa;print $ac[0]." ";
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
#    open(JAK,">>$file2");
    ###print JAK"$ac[0] ";
    ###$n=0;
    for($a=0;$a<@ab;$a++)
    {
	$n++;
	print JAK" $n:$ab[$a]";
    }
    print JAK"\n";
  #  close JAK;
}
###close MAK;


