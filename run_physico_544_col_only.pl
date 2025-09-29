$positve=$ARGV[0];#file having positive motif
    $negative=$ARGV[1];#file having negative motif                                                                                                            
#open(FH1,$ARGV[0]);@posit=<FH1>;
#open(FH2,$ARGV[1]);@negat=<FH2>;
    open(FH3,$ARGV[2]);#file having the PhysicoChemical_aaindex1 ids 
#eg ANDN920101
#ARGP820101
#ARGP820102
#ARGP820103
#AURR980101
    @properties=<FH3>;close FH1,FH2,FH3;
#open(D1,">>tempD1_svm_result");
#open(D3,">>tempD3_svm_result");
#open(D5,">>tempD5_svm_result");
#system "mkdir ../id ../svm_result"; 

foreach $id(@properties){
    chomp($id);
    system "perl ~/progs/calcPhysicoChemical.pl ~/Matrix/physico/physicochemical_544/$id $ARGV[0] >positve.$id ";
    system "perl ~/progs/calcPhysicoChemical.pl ~/Matrix/physico/physicochemical_544/$id $ARGV[1] >negative.$id ";
#system()




  ##  system "perl ~/gpsr_1.0/bin/col2svm -i positve.$id -o positve.$id.svm -s +1";
#    system "perl ~/gpsr_1.0/bin/col2svm -i negative.$id -o negative.$id.svm -s -1";
#    system "perl ~/progs/shuffle.pl positve.$id.svm negative.$id.svm ";
#    system "perl ~/progs/run.pl 1";
    #system "mkdir ../id ../svm_result";
#    system "mkdir ../id/$id";
#    system "cp svm_result ../svm_result/svm_result_$id";
#    system "mv * ../id/$id/.";
 
 

}

