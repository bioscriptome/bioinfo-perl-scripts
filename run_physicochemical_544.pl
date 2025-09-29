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
open(D1,">>tempD1_svm_result");
open(D3,">>tempD3_svm_result");
open(D5,">>tempD5_svm_result");
system "mkdir ../id ../svm_result"; 
foreach $id(@properties){
    chomp($id);
    system "perl ~/progs/calcPhysicoChemical.pl ~/Matrix/physico/physicochemical_544/$id $ARGV[0] >positve.$id ";
    system "perl ~/progs/calcPhysicoChemical.pl ~/Matrix/physico/physicochemical_544/$id $ARGV[1] >negative.$id ";
    system "perl ~/gpsr_1.0/bin/col2svm -i positve.$id -o positve.$id.svm -s +1";
    system "perl ~/gpsr_1.0/bin/col2svm -i negative.$id -o negative.$id.svm -s -1";
    system "perl ~/progs/shuffle.pl positve.$id.svm negative.$id.svm ";
    system "perl ~/progs/run.pl 1";
    system "mkdir ../id ../svm_result";
    system "mkdir ../id/$id";
    system "cp svm_result ../svm_result/svm_result_$id";
    system "mv * ../id/$id/.";
    @array_svm=();
    open(SVM_RES,"svm_result_$id");
    @array_svm=<SVM_RES>;
    close SVM_RES;$on=0;
    foreach $svm(@array_svm){
        $on++;
	if($svm=~/Kernel Parameters .*d=1/){
            print D1 "for properties".$id."\t";
	    for($i=$on+8;$i<$on+20;$i++){
		if($array_svm[$i]=~/\s+(-0.4|-0.3|-0.2|-0.1|0.0|0.1|0.2|0.3|0.4)\s+\d+\s+\d+\s+\d+\s+\d+\s+([\d\.]+)\s+([\d.]+)\s+([\d.]+)\s+([\d.]+)/){
		    print D1 "$1\t$2\t$3\t$4\t$5\t$6";
		    
		    
	    }	
	    }
	}
	    if($svm=~/Kernel Parameters .*d=3/){
		print D3 "for properties".$id."\t";

	    for($i=$on+8;$i<$on+20;$i++){
                if($array_svm[$i]=~/\s+(-0.4|-0.3|-0.2|-0.1|0.0|0.1|0.2|0.3|0.4)\s+\d+\s+\d+\s+\d+\s+\d+\s+([\d\.]+)\s+([\d.]+)\s+([\d.]+)\s+([\d.]+)/){
                    print D3 "$1\t$2\t$3\t$4\t$5\t$6";


		}
	    
	}
	    }
        if($svm=~/Kernel Parameters .*d=5/){
	    print D5 "for properties".$id."\t";

            for($i=$on+8;$i<$on+20;$i++){
                if($array_svm[$i]=~/\s+(-0.4|-0.3|-0.2|-0.1|0.0|0.1|0.2|0.3|0.4)\s+\d+\s+\d+\s+\d+\s+\d+\s+([\d\.]+)\s+([\d.]+)\s+([\d.]+)\s+([\d.]+)/){
                    print D5 "$1\t$2\t$3\t$4\t$5\t$6";


		}

	}
	}

	
	}print D1 "\n";print D3 "\n";
	print D5 "\n";

}
close D1,D3,D5;
