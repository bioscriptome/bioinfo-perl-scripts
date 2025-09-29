#!/usr/bin/perl

#use Getopt::Std;
#getopts('a:');
#getopts('a:b:');

$file_pos=@ARGV[0];
#$file_neg=$opt_b;
$add=0;
open (POSITIVEPAT,">$file_pos");
#open (NEGATIVEPAT,">negeeeee");

open (TEMPPOS2,"temp_pos2") or die "Can't open this file $filename : $!";  ## Only file required for this program to do function
while ($pos2=<TEMPPOS2>)
{
chomp $pos2;
$file=$pos=""; @pos=();@pat=();
$pos2 =~ /(.+?):(.+)/; $file=$1; $pos=$2;
@pos=split'\t',$pos;
open (PATFILE,"$file.pat");
@pat=<PATFILE>; close PATFILE;  ## Zeroth element of @pat contains header line so can leave

##open (FILE,">/home/rahman/PROJECTS/NAD/PSSM/Seq_Pssm/mot19/falsePositive/pos/$file.pat");

#print POSITIVEPAT ">$file\n";
#print NEGATIVEPAT ">$file\n";

for ($c=1;$c<@pat;$c++){  ## pattern starting from 1 so line number resembles exact pattern in need
$find=0;
  for ($d=0;$d<@pos;$d++){ if ($pos[$d] == $c) { $find++; $add++;} }
if ($find == 0)    {# print NEGATIVEPAT "$pat[$c]"; 
#print "$file\t$pos[$d] not found\n"; 
}
else               { print POSITIVEPAT "$pat[$c]"; } ## print FILE "$pat[$c]"; }

                       }

##close FILE;
}
print $add."\n";
close TEMPPOS2;
close POSITIVEPAT;
#close NEGATIVEPAT;

