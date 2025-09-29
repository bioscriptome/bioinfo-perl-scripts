
$tmp=$ARGV[0];
open(FA,">$tmp/code");
print FA "set term png size 1000, 600\n";
print FA "set out \"$tmp/graph.jpg\"\n";
print FA "set terminal png\n";
print FA "set multiplot layout 2,1\n";
#print FA "set terminal png\n";
#print FA "set style fill pattern 4 bo\n";
print FA "set title \"% Inhibition\"\n";
$sirnas=`wc -l $tmp/input.seq |cut -d ' ' -f1`;
chomp($sirnas);
$seeds_n=`cut -f3  $tmp/graph.txt|sort -nrk1|head -1`;
chomp($seeds_n);
print FA "set grid\n";
print FA "set ylabel \"mRNA % inhibition\"\n";
print FA "set xlabel \"siRNA\"\n";
print FA "set xrange [1:$sirnas]\n";
print FA "set yrange[1:100]\n";
print FA "set data style boxes\n";
print FA "set boxwidth 0.1\n";
print FA "set style fill solid\n";
print FA "set bar\n";
print FA "set ytics 10\n";
print FA "set xtics 10\n";

print FA "plot \"$tmp/graph.txt\" using (\$1):(\$2) title \"Threshold 60(60%)\" with lines \n";
print FA "set title \"Offtargets for Each siRNA\"\n";
print FA "set grid\n";
print FA "set ylabel \"Number of offtarget seeds\"\n";
print FA "set xlabel \"siRNA\"\n";
print FA "set xrange [1:$sirnas]\n";
$fin=$seeds_n+10;
print FA "set yrange[1:$fin]\n";
print FA "set data style boxes\n";
print FA "set boxwidth 0.1\n";
print FA "set style fill solid\n";
print FA "set bar\n";
print FA "set ytics 25\n";
print FA "set xtics 10\n";

print FA "plot \"$tmp/graph.txt\"  using (\$1):(\$3) title \"Offtarget seeds\" with lines";








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
