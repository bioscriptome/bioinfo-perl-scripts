#!/usr/bin/perl

open (SVMFILE,"$ARGV[0]");

open (COLFILE,">$ARGV[1]");

while ($line=<SVMFILE>)
{
chomp $line;
@arr=(); $arr1="";
while ($line =~ /\d:(.+?) /g) {$val=""; $val=$1; push (@arr,$val); } # print COLFILE "$val,";  }
$arr1=join",",@arr;
print COLFILE "$arr1\n";

}

close SVMFILE;
close COLFILE;
