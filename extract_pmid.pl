#usage perl extract_pmid.pl  file.txt
open(FH,$ARGV[0]);
@file=<FH>;close FH;
foreach $file(@file){
if($file=~/PMID:\s+(\d+)\s+/){print $1."\n";}

}
