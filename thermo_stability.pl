#!/usr/bin/perl 
use Getopt::Std;
getopts('i:o:');
$file1=$opt_i;
$file2=$opt_o;


if($file1 eq '' || $file2 eq ''){
print "-i: Efficacy_seq file\n-o: Output file that will have SVM format\n";
}else{
open(FO,$file1);
open(FA,">$file2");
@eff_seq=<FO>;
close FO;
foreach $line(@eff_seq){
chomp($line);
($eff,$siRNA)=split(" ",$line);
print FA  $eff." ";
$siRNA=uc($siRNA);
#print "siRNA: $siRNA\n";
$range=18;
my %energies = (
"AA" => -0.093,	#    "AA/TT"
"AC" => -0.224,	#    "AC/TG"
"AG" => -0.208,	#    "AG/TC"
"AT" => -0.110,	#    "AT/TA"
"CA" => -0.211,	#    "CA/GT"
"CC" => -0.326,	#    "CC/GG"
"CG" => -0.236,	#    "CG/GC"
"CT" => -0.208,	#    "CT/GA"
"GA" => -0.235,	#    "GA/CT"
"GC" => -0.342,	#    "GC/CG"
"GG" => -0.326,	#    "GG/CC"
"GT" => -0.224,	#    "GT/CA"
"TA" => -0.133,	#    "TA/AT"
"TC" => -0.235,	#    "TC/AG"
"TG" => -0.211,	#    "TG/AC"
"TT" => -0.093,	#    "TT/AA"
);
    my ($i, $range_sum) = (0, 0.0);
    $start=0;
    for (my $j=0; $j<$range; $i++, $j++) {
       $start++;
       $energy=$energies{substr($siRNA, $i, 2)};
     #  print substr($siRNA, $i, 2).": $energy\n";
     print FA $start.":$energy ";
      $range_sum +=$energy ;
    }
    for ( ; $i<20; $i++) {
      my $eng = $energies{substr($1, $i, 2)};
      last if $eng<$range_sum/$range;
      $range_sum -= $energies{substr($siRNA, $i-$range, 2)};
      $range_sum += $eng;
    }
    next if $i<20; # if not, skip this shRNA candidate
    # save shRNA candidate match location on the oligo
    my $loc = length($`);
    # The following four additional values are then computed for
    # each target site:
    #   1) The Gibbs free energy at 37 C when the antisense siRNA binds to
    #      the target site. Note that we didn't include the initiation
    #      and A/U end compensation energy terms since they will be the
    #      same for all candidates matching the shRNA design pattern
    #      thus they do not change the shRNA preference order.
    #   2) The Gibbs free energy at 37 C for the last six bases on the
    #      3'-end of the target site to unwind
    #   3) The AT base count at the last six bases of the 3'-end of the
    #      target site
    #   4) The Picky computed melting temperature difference between
    #      the oligo target(s) and closest nontarget. This value tells
    #      how specific a shRNA candidate chosen from the oligo will be.
    # These values are output and can be used to rate the shRNAs.

    $temp_diff = $fs[1]-$fs[5];     # melting temperature difference
    my $tail = substr($siRNA, -8, -2);  # last six bases on the target site;
                                    # the two base overhang at 3'-end
                                    # does not participate in binding
    $at_count = ($tail =~ tr/AT/AT/);  # count AT bases
    # calculate tail unwinding energy
    $tail_eng = 0.0;
    for ($i=0; $i<length($tail)-1; $i++) {
      $tail_eng += $energies{substr($tail, $i, 2)};
    }
    # calculate siRNA/target binding energy; note the two 5' overhang
    # bases are participating in the binding
    $bind_eng = 0.0;
    for ($i=0; $i<20; $i++) {
      $bind_eng += $energies{substr($1, $i, 2)};
    }
#    print "dG: $range_sum\ntdG:$tail_eng\nTail AT freq: $at_count\n";
    print FA  ($start+1);print FA ":$range_sum ";print FA ($start+2);print FA ":$tail_eng ";print FA ($start+3);print FA ":$at_count\n";
    }
}
