#!/usr/bin/perl

$file1=$ARGV[0];
$file2=$ARGV[1];

open(MAN,"$file1");
while($line=<MAN>)
{
    chomp($line);
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
    open(MAT,">>$file2");
#    print MAT"$ac[0] ";
    $j=0;
    for($a=0;$a<@ab;$a++)
    {
	$j++;
	print MAT"$ab[$a], ";
    }
    print MAT"\n";
    close MAT;
}
close MAN;
