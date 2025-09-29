#!/usr/bin/perl

#generating positive and negative sequences from efficacy values of sirna i.e. =<20% efficcy +1 and >20% -1;

$file1=$ARGV[0];
$file2=$ARGV[1];

open(FH1,"$file1") or die "Error opening $file1: $!\n" ;
    open(FH2,">>$file2");
while($line=<FH1>)
{
    chomp($line);
    @aa=split(/ /,$line);
    if($aa[0] < 20)
    {
	$aa[0]= "+1";
    }
    else 
    {
      $aa[0]= "-1";

    }

    print FH2"$aa[0] ";
   
    print FH2"$aa[1]\n";
#close FH2;
}
close FH1;

