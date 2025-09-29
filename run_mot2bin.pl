open(FH,$ARGV[0]);
@list=<FH>;
close FH;
foreach $line(@list){
chomp($line);
system "perl /home/nishant/gpsr_1.0/bin/motif2bin -i $line -o $line.bin -x y";

}
