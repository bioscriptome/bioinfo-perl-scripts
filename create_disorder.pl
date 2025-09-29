#!/usr/bin/perl

$progs1="/usr1/webserver/cgibin/ppredyeast/progs";
$ids=$ARGV[2];
$tmp=$ARGV[0];$lengthl=$ARGV[1];
$name=$ARGV[3];
open(RES,"$tmp/dis$ids");@result=<RES>;
close RES;
print "$tmp/";
@sites=();$me=0;
$size_l=scalar(@sites);
$lat=$size_l+1;
if($lengthl < 50){$rangex=5;}
if($lengthl > 50 && $lengthl < 100){$rangex=10;}
if($lengthl > 100 && $lengthl < 200){$rangex=15;}
if($lengthl > 200 && $lengthl < 400){$rangex=25;}
if($lengthl > 400 ){$rangex=100;}
$len=$lengthl-1;
open(TH,">$tmp/DISthr");
print TH "0\t0.6\n$lengthl\t0.6";
print TH "0\t0.6\n$lengthl\t0.6";
system "paste $tmp/pdis$name- $tmp/DISthr >$tmp/DIS_RES$ids";
close TH;
$ran=$me+1;
print $lar."\n";
close RES1;
print "$tmp/code_dis$ids";
open(FA,">$tmp/code_dis$ids");
print FA "set out \"$tmp/DIS$ids.jpg\"\n";
print FA "set terminal png color\n";
print FA "set grid\n";
print FA "set ylabel \"Disorderness\"\n";
print FA "set xlabel \"Amino acid \"\n";
print FA "set xrange [0:$lengthl]\n";
#print FA "set yrange[0:1]\n";
print FA "set yrange[0:10]\n";
print FA "set data style boxes\n";
print FA "set boxwidth 0.1\n";
print FA "set style fill solid\n";
print FA "set bar\n";
print FA "set xtics $rangex\n";
$strs=$strt="(";
$counts=$countt=0;

#print FA "plot \"$tmp/DIS_RES$ids\" using (\$1):(\$3) title \"S residues\" ,\"$tmp/DIS_RES$ids\" (\$4):(\$5) title \"Threshold\" with lines ";
print FA "plot \"$tmp/DIS_RES$ids\" using (\$1):(\$3) title \"S residues\" with lines ";
system "/usr/local/bin/gnuplot $tmp/code_dis$ids";

#print FA "pause 0";
sub max 
{ my $max = pop(@_); 
foreach (@_) 
{ $max = $_ if $_ > $max; 
} 
$max; 
} 
__END__
#!/usr/bin/perl

$progs1="/usr1/webserver/cgibin/ppredyeast/progs";
$ids=$ARGV[2];
$tmp=$ARGV[0];$lengthl=$ARGV[1];
$name=$ARGV[3];
open(RES,"$tmp/dis$ids");@result=<RES>;
close RES;
print "$tmp/";
@sites=();$me=0;
$size_l=scalar(@sites);
$lat=$size_l+1;
if($lengthl < 50){$rangex=5;}
if($lengthl > 50 && $lengthl < 100){$rangex=10;}
if($lengthl > 100 && $lengthl < 200){$rangex=15;}
if($lengthl > 200 && $lengthl < 400){$rangex=25;}
if($lengthl > 400 ){$rangex=100;}
$len=$lengthl-1;
open(TH,">$tmp/DISthr");
print TH "0\t0.6\n$lengthl\t0.6";
print TH "0\t0.6\n$lengthl\t0.6";
system "paste $tmp/pdis$name- $tmp/DISthr >$tmp/DIS_RES$ids";
close TH;
$ran=$me+1;
print $lar."\n";
close RES1;
print "$tmp/code_dis$ids";
open(FA,">$tmp/code_dis$ids");
print FA "set out \"$tmp/DIS$ids.jpg\"\n";
print FA "set terminal png color\n";
print FA "set grid\n";
print FA "set ylabel \"Disorderness\"\n";
print FA "set xlabel \"Amino acid \"\n";
print FA "set xrange [0:$lengthl]\n";
print FA "set yrange[0:1]\n";
print FA "set data style boxes\n";
print FA "set boxwidth 0.3\n";
print FA "set style fill solid\n";
print FA "set bar\n";
print FA "set xtics $rangex\n";
$strs=$strt="(";
$counts=$countt=0;

#print FA "plot \"$tmp/DIS_RES$ids\" using (\$1):(\$3) title \"S residues\" ,\"$tmp/DIS_RES$ids\" (\$4):(\$5) title \"Threshold\" with lines ";
print FA "plot \"$tmp/DIS_RES$ids\" using (\$1):(\$3) title \"S residues\" with lines ";
system "/usr/local/bin/gnuplot $tmp/code_dis$ids";

#print FA "pause 0";
sub max 
{ my $max = pop(@_); 
foreach (@_) 
{ $max = $_ if $_ > $max; 
} 
$max; 
} 

