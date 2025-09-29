#!/usr/bin/perl

open(MAT,">>averageRESULT");
open(MAN,"RESULT");
while($line=<MAN>)
{
 chomp($line);
 if($line=~/test_1/)
 {   
   $avg=$b/5;
   if($avg!=0)
   {
     print MAT"Average is = $avg\n\n";
   }
   print MAT"$line\n";
   $avg=$b=0;
 } 
 
if($line!~/kernel/)
 {    
    $a=0;
    $n++;
    @aa=split(/=/,$line);
    $a=$aa[1];
    $b=$b+$a;
 }
}
$avg=$b/5;
print MAT"Average is = $avg\n";

