open(FH,"$ARGV[0]");
@array=<FH>;
close FH;
foreach $line(@array){
chomp($line);
$line=~/_(\d+).svm/;
print $1."\t";
system "mkdir $1";
system "mv *_$1.svm ./$1/.";

}
