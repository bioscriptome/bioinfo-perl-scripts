#!/usr/bin/perl
#use strict;
# add your ~/lib dir to @INC
use lib '/home/nishant/lib/';
# proceed as usual
open(FH,$ARGV[0]);
@lines=<FH>;
close FH;
foreach $line(@lines){
chomp($line);
@split=split("##",$line);
@data=split("\t",$split[1]);
@sort=sort(@data);
print "@sort\n";
       use Statistics::Lite qw(:all);
        $min= min @data;
        $mean= mean @data;
        %data= statshash @data;
        print "sum= $data{sum} stddev= $data{stddev}\n";
        print statsinfo(@data);
        %std=statsinfo(@data);
        print "!!!!!!!";print %std; print "!!!!!";
}
