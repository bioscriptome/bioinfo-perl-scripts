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
system "perl ~/progs/motif2fasta_sfasta -i $pos -o phos_pos_$win.sfasta -s pos";
system "perl ~/progs/motif2fasta_sfasta -i $neg -o phos_neg_$win.sfasta -s pos";
print "perl ~/progs/motif2fasta_sfasta -i $pos -o phos_pos_$win.sfasta -s pos";

system "mkdir binary aac dpc blosum pam physico run_cascade";
system "perl ~/gpsr_1.0/bin/motif2bin -i $pos -o ./binary/phos_pos_$win.bin -x y ";
system "perl ~/gpsr_1.0/bin/motif2bin -i $neg -o ./binary/phos_neg_$win.bin -x y ";
system "perl ~/gpsr_1.0/bin/col2svm -i ./binary/phos_pos_$win.bin -o ./binary/phos_pos_$win.svm -s +1 ";
system "perl ~/gpsr_1.0/bin/col2svm -i ./binary/phos_neg_$win.bin -o ./binary/phos_neg_$win.svm -s -1 ";
system "perl ~/progs/shuffle.pl ./binary/phos_pos_$win.svm  ./binary/phos_neg_$win.svm";
system "perl ~/progs/run.pl aac";
system "mv p_res1* ./run_cascade/p_res1_bin";
system "mv o_res ./run_cascade/o_res";
system "mv svm_result ./run_cascade/svm_result_bin";

system "rm train_* test_* svm_result";

system "perl ~/gpsr_1.0/bin/pro2aac -i phos_pos_$win.sfasta -o ./aac/phos_pos_$win.aac  ";
system "perl ~/gpsr_1.0/bin/pro2aac -i phos_neg_$win.sfasta -o ./aac/phos_neg_$win.aac  ";
system "perl ~/gpsr_1.0/bin/col2svm -i ./aac/phos_pos_$win.aac -o ./aac/phos_pos_aac_$win.svm -s +1 ";
system "perl ~/gpsr_1.0/bin/col2svm -i ./aac/phos_neg_$win.aac -o ./aac/phos_neg_aac_$win.svm -s -1 ";
system "perl ~/progs/shuffle.pl ./aac/phos_pos_aac_$win.svm ./aac/phos_neg_aac_$win.svm";
system "perl ~/progs/run.pl aac";
system "mv p_res1* ./run_cascade/p_res1_aac";
system "mv svm_result ./run_cascade/svm_result_aac";
system "rm train_* test_* svm_result";




system "perl ~/gpsr_1.0/bin/pro2dpc -i phos_pos_$win.sfasta -o ./dpc/phos_pos_$win.dpc  ";
system "perl ~/gpsr_1.0/bin/pro2dpc -i phos_neg_$win.sfasta -o ./dpc/phos_neg_$win.dpc  ";

system "perl ~/gpsr_1.0/bin/col2svm -i ./dpc/phos_pos_$win.dpc -o ./dpc/phos_pos_dpc_$win.svm -s +1 ";
system "perl ~/gpsr_1.0/bin/col2svm -i ./dpc/phos_neg_$win.dpc -o ./dpc/phos_neg_dpc_$win.svm -s -1 ";
system "perl ~/progs/shuffle.pl ./dpc/phos_pos_dpc_$win.svm ./dpc/phos_neg_dpc_$win.svm";
system "perl ~/progs/run.pl aac";
system "mv svm_result ./run_cascade/svm_result_dpc";
system "mv p_res1* ./run_cascade/p_res1_dpc";
system "rm train_* test_* svm_result";





system "perl ~/progs/calcPhysicoChemical.pl ~/Matrix/blosum/matrixBlosum62.txt  $pos > ./blosum/phos_pos_$win.blsm62 ";
system "perl ~/progs/calcPhysicoChemical.pl ~/Matrix/blosum/matrixBlosum62.txt  $neg > ./blosum/phos_neg_$win.blsm62 ";
system "perl ~/gpsr_1.0/bin/col2svm -i ./blosum/phos_pos_$win.blsm62 -o ./blosum/phos_pos_blsm62_$win.svm -s +1 ";
system "perl ~/gpsr_1.0/bin/col2svm -i ./blosum/phos_neg_$win.blsm62 -o ./blosum/phos_neg_blsm62_$win.svm -s -1 ";
system "perl ~/progs/shuffle.pl ./blosum/phos_pos_blsm62_$win.svm ./blosum/phos_neg_blsm62_$win.svm";
system "perl ~/progs/run.pl aac";
system "mv p_res1* ./run_cascade/p_res1_blsm";
system "mv svm_result ./run_cascade/svm_result_blsm";
system "rm train_* test_* svm_result";





system "perl ~/progs/calcPhysicoChemical.pl ~/Matrix/PAM/PAM250.txt  $pos > ./pam/phos_pos_$win.pam250 ";
system "perl ~/progs/calcPhysicoChemical.pl ~/Matrix/PAM/PAM250.txt  $neg > ./pam/phos_neg_$win.pam250 ";
system "perl ~/gpsr_1.0/bin/col2svm -i ./pam/phos_pos_$win.pam250 -o ./pam/phos_pos_pam250_$win.svm -s +1 ";
system "perl ~/gpsr_1.0/bin/col2svm -i ./pam/phos_neg_$win.pam250 -o ./pam/phos_neg_pam250_$win.svm -s -1 ";
system "perl ~/progs/shuffle.pl ./pam/phos_pos_pam250_$win.svm ./pam/phos_neg_pam250_$win.svm";
system "perl ~/progs/run.pl aac";
system "mv svm_result ./run_cascade/svm_result_pam";
system "mv p_res1* ./run_cascade/p_res1_pam";
system "rm train_* test_* svm_result";



system "perl ~/progs/calcPhysicoChemical.pl ~/Matrix/physico/hydropathy_index/hoops_wood.txt  $pos > ./physico/phos_pos_$win.hoops ";
system "perl ~/progs/calcPhysicoChemical.pl ~/Matrix/physico/hydropathy_index/hoops_wood.txt  $neg > ./physico/phos_neg_$win.hoops ";
system "perl ~/gpsr_1.0/bin/col2svm -i ./physico/phos_pos_$win.hoops -o ./physico/phos_pos_hoops_$win.svm -s +1 ";
system "perl ~/gpsr_1.0/bin/col2svm -i ./physico/phos_neg_$win.hoops -o ./physico/phos_neg_hoops_$win.svm -s -1 ";
system "perl ~/progs/shuffle.pl ./physico/phos_pos_hoops_$win.svm  ./physico/phos_neg_hoops_$win.svm ";
system "perl ~/progs/run.pl phy";
system "mv svm_result ./run_cascade/svm_result_hoops";
system "mv p_res1* ./run_cascade/p_res1_hoops";
system "rm train_* test_* svm_result";




system "perl ~/progs/calcPhysicoChemical.pl ~/Matrix/physico/matrixPhysicoChem.txt  $pos > ./physico/phos_pos_$win.physico5 ";
system "perl ~/progs/calcPhysicoChemical.pl ~/Matrix/physico/matrixPhysicoChem.txt  $neg > ./physico/phos_neg_$win.physico5 ";
system "perl ~/gpsr_1.0/bin/col2svm -i ./physico/phos_pos_$win.physico5 -o ./physico/phos_pos_physico5_$win.svm -s +1 ";
system "perl ~/gpsr_1.0/bin/col2svm -i ./physico/phos_neg_$win.physico5 -o ./physico/phos_neg_physico5_$win.svm -s -1 ";
system "perl ~/progs/shuffle.pl ./physico/phos_pos_physico5_$win.svm ./physico/phos_neg_physico5_$win.svm ";
system "perl ~/progs/run.pl phy";
system "mv svm_result ./run_cascade/svm_result_physico5";
system "mv p_res1* ./run_cascade/p_res1_physico5";
system "rm train_* test_* svm_result";
    system "paste -d ',' p_res1_aac p_res1_dpc p_res1_blsm p_res1_pam p_res1_bin p_res1_hoops p_res1_physico5 >phos_15_aac_dpc_blsm_pam_bin_s_physico5.col";

#system "perl ~/gpsr_1.0/bin/col2weka -i $pos -o un_pos_15.sfasta -s pos";


