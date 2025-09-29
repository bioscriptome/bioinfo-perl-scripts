#open(FH,$ARGV[0]);#positive motife file
#open(FH,$ARGV[1]);#negative motife file  
$pos=$ARGV[0];
#($positive,$d)=split('.',$pos);
$neg=$ARGV[1];
$win=$ARGV[2];
print $pos;
#($negative,$d)=split('.',$neg);
#system "perl ~/progs/motif2fasta_sfasta -i $pos -o phos_pos_$win.sfasta -s pos";
#system "perl ~/progs/motif2fasta_sfasta -i $neg -o phos_neg_$win.sfasta -s pos";
#print "perl ~/progs/motif2fasta_sfasta -i $pos -o phos_pos_$win.sfasta -s pos";

system "mkdir binary aac dpc blosum pam physico";
system "perl ~/gpsr_1.0/bin/motif2bin -i $pos -o ./binary/phos_pos_$win.bin -x y ";
system "perl ~/gpsr_1.0/bin/motif2bin -i $neg -o ./binary/phos_neg_$win.bin -x y ";
#system "perl ~/gpsr_1.0/bin/col2svm -i ./binary/phos_pos_$win.bin -o ./binary/phos_pos_$win.svm -s +1 ";
#system "perl ~/gpsr_1.0/bin/col2svm -i ./binary/phos_neg_$win.bin -o ./binary/phos_neg_$win.svm -s -1 ";


#system "perl ~/gpsr_1.0/bin/pro2aac -i phos_pos_$win.sfasta -o ./aac/phos_pos_$win.aac  ";
#system "perl ~/gpsr_1.0/bin/pro2aac -i phos_neg_$win.sfasta -o ./aac/phos_neg_$win.aac  ";
#system "perl ~/gpsr_1.0/bin/col2svm -i ./aac/phos_pos_$win.aac -o ./aac/phos_pos_aac_$win.svm -s +1 ";
#system "perl ~/gpsr_1.0/bin/col2svm -i ./aac/phos_neg_$win.aac -o ./aac/phos_neg_aac_$win.svm -s -1 ";

#system "perl ~/gpsr_1.0/bin/pro2dpc -i phos_pos_$win.sfasta -o ./dpc/phos_pos_$win.dpc  ";
#system "perl ~/gpsr_1.0/bin/pro2dpc -i phos_neg_$win.sfasta -o ./dpc/phos_neg_$win.dpc  ";

#system "perl ~/gpsr_1.0/bin/col2svm -i ./dpc/phos_pos_$win.dpc -o ./dpc/phos_pos_dpc_$win.svm -s +1 ";
#system "perl ~/gpsr_1.0/bin/col2svm -i ./dpc/phos_neg_$win.dpc -o ./dpc/phos_neg_dpc_$win.svm -s -1 ";
open(FH3,$ARGV[3]);#file having the PhysicoChemical_aaindex1 ids                                                                                      
    @properties=<FH3>;
system "mkdir ../id ../svm_result";
foreach $id(@properties){
    chomp($id);
    system "perl ~/progs/calcPhysicoChemical.pl ~/Matrix/physico/physicochemical_544/$id $ARGV[0] >pos.$id ";
    system "perl ~/progs/calcPhysicoChemical.pl ~/Matrix/physico/physicochemical_544/$id $ARGV[1] >neg.$id ";
    system "paste -d ',' ./binary/phos_pos_$win.bin pos.$id >phos_pos_$win.bin.$id";
    system "paste -d ',' ./binary/phos_neg_$win.bin neg.$id >phos_neg_$win.bin.$id";
    system "perl ~/gpsr_1.0/bin/col2svm -i phos_pos_$win.bin.$id -o phos_pos_$win.bin.$id.svm -s +1";                                                   
    system "perl ~/gpsr_1.0/bin/col2svm -i phos_neg_$win.bin.$id -o phos_neg_$win.bin.$id.svm -s -1"; 
    system "perl ~/progs/shuffle.pl phos_pos_$win.bin.$id.svm phos_neg_$win.bin.$id.svm ";
    system "perl ~/progs/run.pl cgl";
    system "mkdir ../id/$id";
    system "cp svm_result ../svm_result/svm_result_$id";
    system "ls * |grep -v nohup.txt|xargs rm -rf ";
    @array_svm=();
}
    open(SVM_RES,"../svm_result/svm_result_$id");
    @array_svm=<SVM_RES>;
    close SVM_RES;$on=0;


#system "perl ~/progs/calcPhysicoChemical.pl ~/Matrix/blosum/matrixBlosum62.txt  $pos > ./blosum/phos_pos_$win.blsm62 ";
#system "perl ~/progs/calcPhysicoChemical.pl ~/Matrix/blosum/matrixBlosum62.txt  $neg > ./blosum/phos_neg_$win.blsm62 ";
#system "perl ~/gpsr_1.0/bin/col2svm -i ./blosum/phos_pos_$win.blsm62 -o ./blosum/phos_pos_blsm62_$win.svm -s +1 ";
#system "perl ~/gpsr_1.0/bin/col2svm -i ./blosum/phos_neg_$win.blsm62 -o ./blosum/phos_neg_blsm62_$win.svm -s -1 ";

#system "perl ~/progs/calcPhysicoChemical.pl ~/Matrix/PAM/PAM250.txt  $pos > ./pam/phos_pos_$win.pam250 ";
#system "perl ~/progs/calcPhysicoChemical.pl ~/Matrix/PAM/PAM250.txt  $neg > ./pam/phos_neg_$win.pam250 ";
#system "perl ~/gpsr_1.0/bin/col2svm -i ./pam/phos_pos_$win.pam250 -o ./pam/phos_pos_pam250_$win.svm -s +1 ";
#system "perl ~/gpsr_1.0/bin/col2svm -i ./pam/phos_neg_$win.pam250 -o ./pam/phos_neg_pam250_$win.svm -s -1 ";

#system "perl ~/progs/calcPhysicoChemical.pl ~/Matrix/physico/hydropathy_index/hoops_wood.txt  $pos > ./physico/phos_pos_$win.hoops ";
#system "perl ~/progs/calcPhysicoChemical.pl ~/Matrix/physico/hydropathy_index/hoops_wood.txt  $neg > ./physico/phos_neg_$win.hoops ";
#system "perl ~/gpsr_1.0/bin/col2svm -i ./physico/phos_pos_$win.hoops -o ./physico/phos_pos_hoops_$win.svm -s +1 ";
#system "perl ~/gpsr_1.0/bin/col2svm -i ./physico/phos_neg_$win.hoops -o ./physico/phos_neg_hoops_$win.svm -s -1 ";

#system "perl ~/progs/calcPhysicoChemical.pl ~/Matrix/physico/matrixPhysicoChem.txt  $pos > ./physico/phos_pos_$win.physico5 ";
#system "perl ~/progs/calcPhysicoChemical.pl ~/Matrix/physico/matrixPhysicoChem.txt  $neg > ./physico/phos_neg_$win.physico5 ";
#system "perl ~/gpsr_1.0/bin/col2svm -i ./physico/phos_pos_$win.physico5 -o ./physico/phos_pos_physico5_$win.svm -s +1 ";
#system "perl ~/gpsr_1.0/bin/col2svm -i ./physico/phos_neg_$win.physico5 -o ./physico/phos_neg_physico5_$win.svm -s -1 ";


#system "perl ~/gpsr_1.0/bin/col2weka -i $pos -o un_pos_15.sfasta -s pos";


