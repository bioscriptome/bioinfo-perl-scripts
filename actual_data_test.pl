#!/usr/bin/perl

system "rm actual_data";
$file1=$ARGV[0];
open(IN,"$file1");
while($line=<IN>)
{
    chomp($line);
    $aa[$i]=$line;
    $i++;
}
close IN;
system "cut -f1 -d ' ' $file1>>actual_data";

