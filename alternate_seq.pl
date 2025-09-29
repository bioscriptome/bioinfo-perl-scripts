#!/usr/bin/perl

###to arrange positive and negative sequences alternativily and use   file1   which have more number of sequences;
###./alternate_seq.pl infile1 infile2 outputfile3 ######

$file1=$ARGV[0];
$file2=$ARGV[1];
$file3=$ARGV[2];

open(FH1,"$file1");
open(FH2,"$file2");

while($line1=<FH1>)
{
    open(FH3,">>$file3");
    print FH3"$line1";
    
    $line2=<FH2>;
    
    if($line2 !=EOF)
    {
	print FH3"$line2";
    }   
}
close FH3;
