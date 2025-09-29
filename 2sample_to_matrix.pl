#use POSIX;
#use Math::Round
#print "\nHI\n";
open(FH,$ARGV[0]);
open(FA,">unique");
@array11=('A','C','D','E','F','G','H','I','K','L','M','N','P','Q','R','S','T','V','W','Y');
foreach (@array11){print FA $_;print FA "\n";}
@array=<FH>;
close FH;
$start=$ARGV[1];
open(FA1,">XYZ");
foreach $array(@array){
if($array=~/([-\d+]+)\t([A-Za-z]+)\t([-\.0-9]+).+/){
#$round=sprintf("%.2f", $2);
if($1!=0){
print FA1 $2."\t".($3*100)."\n";
}
}
}
#open(FA,">".$ARGV[2]);
@list=(((-$start)..0),(1..$start));
#foreach $id (@list){print FA1 ($id)."\n";}close FA;
system "perl ~/progs/phosphorylation_sites_with_id.pl XYZ unique  $ARGV[2]";
system "rm XYZ unique";
open(temp,">tempp");

open(FH11,$ARGV[2]);
    while($line=<FH11>){
$line=~s/\#\#/\t/g;
print temp $line;

}
system "mv tempp $ARGV[2]";
