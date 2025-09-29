perl -n -e '$line=$_;@split=split("\t\t",$line);if($split[1]=~/(\.{15})/){print $split[0]."\t$split[1]\n";};' out   |sort -u >out_id_seq

normalize -to0 :perl -n -e '$line=$_;chomp($line);$line=~s/  1:/\@1:/g;@split=split("@",$line);undef $norm;$norm=$split[0]; if($norm<0){$norm='0.0'}else{$norm=$norm;}printf("%3.2f",$norm);print "  $split[1]\n"' hiv_vir_morbillo_814_bin76.pat  |cut -d ' ' -f1,2
reverse complement:perl -n -e '$eff_seq=$_;chomp($eff_seq);($eff,$seq)=split(" ",$eff_seq);$seq=~tr/uU/tt/;$revseq=  reverse($seq);$revseq =~ tr/ACGTacgt/TGCAtgca/;print FA $eff." ".$revseq."\n";'

filter:perl -n -e '$line=$_;chomp($line);@split=split(" ",$line);undef $norm;$norm=$split[0]/100; if($norm<0){$norm='0.0'}else{$norm=$norm;}printf("%3.2f",$norm);print "  $split[1]\n"' virsirnapred_1020.txt 
[nishant@master 10fold_1028]$ vi ~/progs/CMD_perl/code.pl


