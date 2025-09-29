open(FH,$ARGV[0]);
@array=<FH>;
close FH;
foreach $id_seq(@array){
chomp($id_seq);
($id,$seq)=split("\t",$id_seq);
$id=~s/\s//g;
$seq=~s/\s//g;
system "rm TEMP";
open(TEMP,">TEMP");
print TEMP ">$id\n";
print TEMP "$seq";
system "/home/nishant/blast-2.2.24/bin/blastall -p blastn -i TEMP -d ../../db_human/human_genomic -e 1000  -o ./offtarget/$id.html -b 3000 -W 9 -m 1  -q -4 -r 5 -T T"

}
