#!/usr/bin/perl

$file1=$ARGV[0];
$file2=$ARGV[1];
open(MAN,"$file1");
@ef_seq=<MAN>;close MAN;$i=0;
 foreach $line(@ef_seq)
{

    @array=split(/ /,$line);
    $array[0]=~s/\s//g;
    $sort[$i++]=$array[0];

}
my @sorted_numbers = sort {$b <=> $a} @sort;
my @sorted_numbers_rev = sort {$a <=> $b} @sort;
$largest=$sorted_numbers[0];
$smallest=$sorted_numbers_rev[0];
open(MAT,">$file2");

 foreach $line(@ef_seq)
{
    chomp($line);
    @aa=split(/ /,$line);
    $a=($aa[0] -$smallest)/($largest -$smallest);
  #  $a=$aa[0]/127.8;

    printf MAT"%6.4f ",$a; 
    print MAT"$aa[1]\n";

    #$asd=<STDIN>;
}
close MAT;

close MAN;
