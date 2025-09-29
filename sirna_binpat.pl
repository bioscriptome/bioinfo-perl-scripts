#!/usr/bin/perl

$file1=$ARGV[0];
$file2=$ARGV[1];

open(MAN,"$file1");
open(MAN1,">$file2.bin");
while($line=<MAN>)
{
    chomp($line);
    $varu="";
    $var=0;
    @ac=split(/\t/,$line);
    $ac[1]=~s/\s//g;
    @aa=split(//,$ac[1]);
    #$len1=@aa;
    #print "$len1\n";
    for($c=0;$c<@aa;$c++)
    {
	if($aa[$c] eq "A")
	{
	    $var="1000";
	}
	if($aa[$c] eq "U")
	{
	    $var="0100";
	}
	if($aa[$c] eq "G")
	{
	    $var="0010";
	}
	if($aa[$c] eq "C")
	{
	    $var="0001";
	}
	$varu.="$var";
    }
    
    @ab=split(//,$varu);
    #$len=@ab;
    #print "$len\n";
    open(MAT,">>$file2");
    print MAT"$ac[0] ";
    $j=0;
    for($a=0;$a<@ab;$a++)
    {
	$j++;
	print MAT"$j:$ab[$a] ";
	print MAN1"$ab[$a],"
    }
    print MAT"\n";
 print MAN1"\n";
    close MAT;
}
close MAN;
close MAN1;
