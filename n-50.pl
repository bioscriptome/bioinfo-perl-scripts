#!/usr/bin/perl -w
$file=$ARGV[0];
open(IN,$file);
my $cd='0';
my $qt = '0';
my $at ='0';
my $g ='0';
my $cp='0';
my $t='0';
while ($line=<IN>){
chomp($line);
    if($line=~"^>")
{$cd++;}
elsif($line !~ /\>/){
chomp($line);
@b = split(//,$line);
foreach $c(@b){
if($c eq "N")
{$qt++;}
elsif($c eq "A")
{$at++;}
elsif($c eq "G")
{$g++;}
elsif($c eq "C")
{$cp++;}
elsif($c eq "T")
{$t++;}
}}}
use strict;
my ($len,$total)=(0,0);
my @x;
while(<>){
	if(/^[\>\@]/){
		if($len>0){
			$total+=$len;
			push @x,$len;
		}
		$len=0;
	}
	else{
		s/\s//g;
		$len+=length($_);
	}
}
if ($len>0){
	$total+=$len;
	push @x,$len;
}	
my  $siz = ($total*0.000001);
@x=sort{$b<=>$a} @x; 
my ($count,$half)=(0,0);
for (my $j=0;$j<@x;$j++){
	$count+=$x[$j];
	if (($count>=$total/2)&&($half==0)){
print "Fasta Sequences=$cd\tTotal size=$siz(Mb)\tN 50=$x[$j]\t";
my $nct =($qt*100)/$total;
my $act =($at*100)/$total;
my $gct =($g*100)/$total;
my $cct =($cp*100)/$total;
my $tct =($t*100)/$total;
my $gcct= ($g+$cp);
my $atct= ($at+$t);
my $gccct = ($gcct*100)/$total;
my $atcct =($atct*100)/$total; 

print "N = $qt\t";
printf ("%.2f",$nct);
print "%\t\t";

print "A = $at\t";
printf ("%.2f",$act);
print "%\t\t";

print "G = $g\t";
printf ("%.2f",$gct);
print "%\t\t";

print "C = $cp\t";
printf ("%.2f",$cct);
print "%\t\t";

print "T = $t\t";
printf ("%.2f",$tct);
print "%\t";

print "GC count =$gcct\t";
printf ("%.2f",$gccct);
print"%\t\t";
print "AT count =$atct\t";
printf ("%.2f",$atcct);
print"%\n";
		$half=$x[$j]
	}
elsif ($count>=$total*0.9){
#		print "N90: $x[$j]\n";
		exit;
    }
}
