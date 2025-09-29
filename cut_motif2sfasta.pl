#!usr/bin/perl -w  

#$win=$ARGV[1];
@win=qw(5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39 41 43 45 47 49);
$len=$ARGV[2];
$mid=($len-1)/2;
$mid1=$mid+1;
foreach $win(@win){
$rng= (($win -1)/2);
$rg1=$mid1-$rng;
$rg2=$mid1+$rng;
system "cut -c$rg1-$rg2 $ARGV[0]";
#open(FH1,">>$ARGV[1]\_$win");
#print FH1 "$ARGV[3]##$mot\n";

#			}
#close FH1;close FH;

		 }
