#!/usr/bin/perl
$dir=$ARGV[1];#print "$dir;xxxxxxxxx\n"
$file1=$ARGV[0];
$i=0;
open(MAN,"$file1");
while($line=<MAN>)
{
    chomp($line);
    $i++;
    $k=$i%5;
    if($k==1)
    {
	open(MAT,">>$dir/set_1");
	print MAT"$line\n";
	close MAT;
    }
    if($k==2)
    {
	open(MAT,">>$dir/set_2");
	print MAT"$line\n";
	close MAT;
    }
    if($k==3)
    {
	open(MAT,">>$dir/set_3");
	print MAT"$line\n";
	close MAT;
    }
    if($k==4)
    {
	open(MAT,">>$dir/set_4");
	print MAT"$line\n";
	close MAT;
    }
    if($k==0)
    {
	open(MAT,">>$dir/set_5");
	print MAT"$line\n";
	close MAT;
    }
    
}
