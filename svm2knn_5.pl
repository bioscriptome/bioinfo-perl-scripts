for($i=1;$i<6;$i++){
#$file="train_$i";
#chomp($file);
#system "cut -f1 $file>tags";
#system "cut  -d ' ' -f2- $file>scores";
#system "sed 's/\[0-9\]\*:/,/g' scores>score";
#system "paste -d ',' score tags>train_$i.arff";
#system "rm score* tags";
system "perl ~/progs/knn4rmsvm.pl  train\_$i  train\_$i\.arff";
system "perl ~/progs/knn4rmsvm.pl  test\_$i  test\_$i\.arff";
#print "perl ~/progs/knn4rmsvm.pl  train\_$i  train\_$i\.arff";
#$file="test_$i";
#chomp($file);
#system "cut -f1 $file>tags";
#system "cut  -d ' ' -f2- $file>scores";
#system "sed 's/\[0-9\]\*:/,/g' scores>score";
#system "paste -d ',' score tags>test_$i.arff";
#system "rm score* tags";
}
__END__
open(FH,$ARGV[0]);
@array=<FH>;
close FH;
foreach $line(@array){
chomp($line);


}
