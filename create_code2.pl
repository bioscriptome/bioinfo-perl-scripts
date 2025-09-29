
$tmp=$ARGV[0];
open(FA,">$tmp/code");
print FA "set out \"$tmp/graph.jpg\"\n";
print FA "set terminal png\n";
print FA "set style fill pattern 4 bo\n";
print FA "set grid\n";
print FA "set ylabel \"Phosphorylation Probabilty\"\n";
print FA "set xlabel \"S/T position in sequnece\"\n";
print FA "set xrange [1:25]\n";
print FA "set yrange[1:100]\n";
print FA "set data style boxes\n";
print FA "set boxwidth 0.1\n";
print FA "set style fill solid\n";
print FA "set bar\n";
print FA "set ytics 10\n";
print FA "set xtics 1\n";

print FA "plot \"$tmp/graph.txt\" using (\$1):(\$2) title \"Threshold 60(60%)\" with lines ,\"$tmp/graph.txt\" using (\$1):(\$3) title \"Disorderness(0 least and  100 most)\" with lines";
system "/usr/bin/gnuplot $tmp/code";

#print FA "pause 0";
#sub max 
#{ my $max = pop(@_);
#foreach (@_)
#{ $max = $_ if $_ > $max;
#}
#$max;
#}
#
