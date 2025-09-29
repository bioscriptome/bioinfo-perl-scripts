open(FH1,$ARGV[0]);
@array=<FH1>;
close FH1;
##open(FH,$seq_id);
##@seq=<FH>;
foreach $seq_id(@array){

@split=split("##",$seq_id);
$seq=$split[1];
for($i=0;$i<(length($seq)-19);$i++){
$siRNA=substr($seq,$i,19);
open(FA,">TEMP");
print FA ">SIRNA\n$siRNA";
close FA;
print $siRNA."\n";

system "/home/nishant/blast-2.2.24/bin/blastall -p blastn -i TEMP -d ./db/All_14_Family  -e 100  -o RESULT/$siRNA -b 30000 -W 9 -m 1  -q -4 -r 5";



}}
