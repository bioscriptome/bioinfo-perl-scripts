#!/usr/perl/bin

if(open(FH,$ARGV[0])){print "file opened";}else{print "cudn't open";}
while($mot=<FH>){
if($mot=~/>/)
{ print $mot;
    $seq=<FH>;
print $seq}


}
