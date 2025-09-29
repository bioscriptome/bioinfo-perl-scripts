#!/usr/bin/perl

$file1=$ARGV[0];
$file2=$ARGV[1];
open(MAN,"$file1");
while($line=<MAN>)
{
    chomp($line);
    @aa=split(/ /,$line);
    $a=$aa[0]/127.8;
    open(MAT,">>$file2");
    printf MAT"%6.4f ",$a; 
    print MAT"$aa[1]\n";
    close MAT;
    #$asd=<STDIN>;
}
close MAN;
