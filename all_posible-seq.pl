use Getopt::Std;
getopts('t:l:o:');
$type=$opt_t;
$length=$opt_l;
$output=$opt_o;
if($type eq ''){print 'Programe to create all posible sequences of given length
usage: perl all_posible-seq.pl -t[p:protein /n:nucleotide] -l seqlength -o outputfile
';}
else{
if($type eq 'p'){$type='p';@combs = doit($length, [ qw(A C D E F G H I K L M N P Q R S T V W Y) ]);}else{$type='n';@combs = doit($length, [ qw( A T G C ) ]);}
open(OUT,">$output");
#@combs = doit($ARGV[0], [ qw( A T G C ) ]);
foreach $seq(@combs){
print OUT $seq."\n";
 sub doit {
     my ($n, $sym) = @_;
     my $a = [];
     doit_guts($n, $sym, $a, '');
     return map {$_ || ()} @$a;
 }
 sub doit_guts {
     my ($n, $sym, $store, $str)  = @_;
     if (!$n) {
         return $str;
     }
     else {
         foreach my $s (@$sym) {
             push @$store, doit_guts($n-1, $sym, $store, $str.$s);
         }
     }
 }
}
}
