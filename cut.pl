#!usr/bin/perl -w  

#$win=$ARGV[1];
@win=qw(5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39 41 43 45 47 49);
foreach $win(@win){

$rng= (($win -1)/2);
open(FH,"$ARGV[0]");
while($seq1=<FH>)	{
@seq= split ("", $seq1);
@motif= @seq[(24 - ($rng-1))..(24 + ($rng+1))];
$mot= join ('',@motif);
open(FH1,">>$ARGV[1]\_$win");
print FH1 "$mot\n";

			}
close FH1;close FH;

		 }
