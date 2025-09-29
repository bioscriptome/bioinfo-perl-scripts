$file=$ARGV[0];
chomp($file);
system "cut -f1 $file>tags";
system "cut  -d ' ' -f2- $file>scores";
system "sed 's/\[0-9\]\*:/,/g' scores>score";
system "paste -d ',' score tags>$ARGV[1]";
system "rm score* tags";

__END__
open(FH,$ARGV[0]);
@array=<FH>;
close FH;
foreach $line(@array){
chomp($line);


}
