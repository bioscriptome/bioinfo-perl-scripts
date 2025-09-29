#!/usr/bin/perl

$file1=$ARGV[0];
###$file2=$ARGV[1];
chomp($file1);

open(MAN,"$file1");
while($line=<MAN>) 
{
    chomp ($line);
    $line=~ s/\s+/ /g;
    chomp($line);
    @aa=split(/ /,$line);
    if(@aa >1){
	
	{
	    print"$line\n";
	}
    }
}
