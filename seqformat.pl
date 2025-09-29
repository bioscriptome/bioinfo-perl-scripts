#!/usr/bin/perl

$file1=$ARGV[0];
$file2=$ARGV[1];
chomp($file1);

open(MAN,"$file1");
while($line=<MAN>) 
{
    chomp ($line);
    ###$n1++;
    ###print "$n1 ::";
    
    if ($line=~ /\d/) 
    {
	chomp($line);
	$line=~ s/\s+/ /g;
	open(MAP,">>$file2");
	print MAP "$line\n";
	###print "$line\n";
    }
}
close MAP;
