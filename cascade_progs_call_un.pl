#open(FH,$ARGV[0]);#positive motife file
#open(FH,$ARGV[1]);#negative motife file  
$pos=$ARGV[0];
($positive,$d)=split('.',$pos);
$neg=$ARGV[1];
$win=$ARGV[2];
$neg_sfasta=$ARGV[4];
$pos_sfasta=$ARGV[3];

print $pos;
($negative,$d)=split('.',$neg);
system "perl ~/progs/motif2fasta_sfasta -i $pos -o un_pos_$win.sfasta -s pos";
system "perl ~/progs/motif2fasta_sfasta -i $neg -o un_neg_$win.sfasta -s pos";
print "perl ~/progs/motif2fasta_sfasta -i $pos -o un_pos_$win.sfasta -s pos";

system "mkdir binary aac dpc blosum pam physico";
system "perl ~/gpsr_1.0/bin/motif2bin -i $pos -o ./binary/un_pos_$win.bin -x y ";
system "perl ~/gpsr_1.0/bin/motif2bin -i $neg -o ./binary/un_neg_$win.bin -x y ";
system "perl ~/gpsr_1.0/bin/col2svm -i ./binary/un_pos_$win.bin -o ./binary/un_pos_$win.svm -s +1 ";
system "perl ~/gpsr_1.0/bin/col2svm -i ./binary/un_neg_$win.bin -o ./binary/un_neg_$win.svm -s -1 ";
system "paste -d ',' ./binary/un_pos_$win.bin ./binary/un_neg_$win.bin > ./binary/eval_1";

system "perl ~/gpsr_1.0/bin/pro2aac -i un_pos_$win.sfasta -o ./aac/un_pos_$win.aac  ";
system "perl ~/gpsr_1.0/bin/pro2aac -i un_neg_$win.sfasta -o ./aac/un_neg_$win.aac  ";
system "perl ~/gpsr_1.0/bin/col2svm -i ./aac/un_pos_$win.aac -o ./aac/un_pos_aac_$win.svm -s +1 ";
system "perl ~/gpsr_1.0/bin/col2svm -i ./aac/un_neg_$win.aac -o ./aac/un_neg_aac_$win.svm -s -1 ";
system "paste -d ',' ./aac/un_pos_aac_$win.aac ./aac/un_neg_aac_$win.aac > ./aac/eval_1";

system "perl ~/gpsr_1.0/bin/pro2dpc -i un_pos_$win.sfasta -o ./dpc/un_pos_$win.dpc  ";
system "perl ~/gpsr_1.0/bin/pro2dpc -i un_neg_$win.sfasta -o ./dpc/un_neg_$win.dpc  ";

system "perl ~/gpsr_1.0/bin/col2svm -i ./dpc/un_pos_$win.dpc -o ./dpc/un_pos_dpc_$win.svm -s +1 ";
system "perl ~/gpsr_1.0/bin/col2svm -i ./dpc/un_neg_$win.dpc -o ./dpc/un_neg_dpc_$win.svm -s -1 ";
system "paste -d ',' ./dpc/un_pos_$win.dpc ./dpc/un_neg_$win.dpc > ./dpc/eval_1";



system "perl ~/progs/calcPhysicoChemical.pl ~/Matrix/blosum/matrixBlosum62.txt  $pos > ./blosum/un_pos_$win.blsm62 ";
system "perl ~/progs/calcPhysicoChemical.pl ~/Matrix/blosum/matrixBlosum62.txt  $neg > ./blosum/un_neg_$win.blsm62 ";
system "perl ~/gpsr_1.0/bin/col2svm -i ./blosum/un_pos_$win.blsm62 -o ./blosum/un_pos_blsm62_$win.svm -s +1 ";
system "perl ~/gpsr_1.0/bin/col2svm -i ./blosum/un_neg_$win.blsm62 -o ./blosum/un_neg_blsm62_$win.svm -s -1 ";
system "paste -d ',' ./blosum/un_pos_$win.blsm62  ./blosum/un_neg_$win.blsm62 > ./blosum/eval_1";


system "perl ~/progs/calcPhysicoChemical.pl ~/Matrix/PAM/PAM250.txt  $pos > ./pam/un_pos_$win.pam250 ";
system "perl ~/progs/calcPhysicoChemical.pl ~/Matrix/PAM/PAM250.txt  $neg > ./pam/un_neg_$win.pam250 ";
system "perl ~/gpsr_1.0/bin/col2svm -i ./pam/un_pos_$win.pam250 -o ./pam/un_pos_pam250_$win.svm -s +1 ";
system "perl ~/gpsr_1.0/bin/col2svm -i ./pam/un_neg_$win.pam250 -o ./pam/un_neg_pam250_$win.svm -s -1 ";
system "paste -d ',' ./pam/un_pos_pam250_$win.svm ./pam/un_neg_pam250_$win.svm > ./pam/eval_1";

system "perl ~/progs/calcPhysicoChemical.pl ~/Matrix/physico/hydropathy_index/hoops_wood.txt  $pos > ./physico/un_pos_$win.hoops ";
system "perl ~/progs/calcPhysicoChemical.pl ~/Matrix/physico/hydropathy_index/hoops_wood.txt  $neg > ./physico/un_neg_$win.hoops ";
system "perl ~/gpsr_1.0/bin/col2svm -i ./physico/un_pos_$win.hoops -o ./physico/un_pos_hoops_$win.svm -s +1 ";
system "perl ~/gpsr_1.0/bin/col2svm -i ./physico/un_neg_$win.hoops -o ./physico/un_neg_hoops_$win.svm -s -1 ";
system "paste -d ',' ./physico/un_pos_hoops_$win.svm ./physico/un_neg_hoops_$win.svm > ./physico/eval_1";



#system "perl ~/gpsr_1.0/bin/col2weka -i $pos -o un_pos_15.sfasta -s pos";


