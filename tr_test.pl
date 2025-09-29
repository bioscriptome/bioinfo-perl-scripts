#!/usr/bin/perl

$dir=$ARGV[0];#print "\n\n$dir\n\nxxxxxxxxxxxxxxxx";
for($c=1;$c<6;$c++)
{
    for($d=1;$d<6;$d++)
    {
	if($d==$c)
	{
	    system "cat $dir/set_$d> $dir/test_$c";
	}
	else
	{
	    system "cat $dir/set_$d>> $dir/train_$c";
	}
    }
}

system "rm $dir/set_*";
