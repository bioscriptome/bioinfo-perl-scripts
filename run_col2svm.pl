open(FH,$ARGV[0]);
@list=<FH>;
close FH;
foreach $line(@list){
chomp($line);
system "perl /home/nishant/gpsr_1.0/bin/col2svm -i $line -o $line.svm  -s $ARGV[1]";

}
