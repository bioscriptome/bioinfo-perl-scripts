@combs = doit(4, [ qw( A T G C ) ]);
print "@combs";
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
