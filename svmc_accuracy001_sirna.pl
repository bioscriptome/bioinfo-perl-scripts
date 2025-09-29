#!/usr/bin/perl
open(FH,"observed_data");
while($line=<FH>){     
     chomp($line);
     $aa[$k]=$line;
     $k++;
     #print"@aa\n";
 }
#close FH;

open(FH1,"actual_data");
while($line1=<FH1>){
    chomp($line1);
    #print"$line1\n";
    @bb=split(" ",$line1);
        if($bb[0] eq "+1"){
	    $seq="P";
        }
        if($bb[0] eq "-1"){
            $seq="N";
        }
    $cc[$k1]=$seq;
    $k1++;
   #print "$seq\n";
}
#close FH1;

for($thres=-1.5; $thres<1.5; $thres=($thres+0.001)){
    $tp=$fn=$fp=$tn=0;
#####true positive, false negative, false positive, true negative;
    for($k2=0; $k2<@aa; $k2++){
	if(($cc[$k2] eq "P") && ($aa[$k2]>=$thres)){
	    $tp++;
	}
        elsif(($cc[$k2] eq "P") && ($aa[$k2]<$thres)){
            $fn++;
        }
        elsif(($cc[$k2] eq "N") && ($aa[$k2]>$thres)){
            $fp++;
        }
        elsif(($cc[$k2] eq "N") && ($aa[$k2]<$thres)){
            $tn++;
        }
    }
      # print"$tp==$fn==$fp==$tn\n";
    if(($tp>0) && ($tn>0)){
	$tes_pos=$tp+$fp;
	$tes_neg=$tn+$fn;
	$tot_pos=$tp+$fn;
	$tot_neg=$tn+$fp;
#####total positive, total negative, tested positive, tested negative;
	$tot=$tp+$fn+$fp+$tn;
### $tot=$tes_pos+$tes_neg && $tot=$tot_pos+$tot_neg;
	$ppv=($tp/$tes_pos)*100;
	$npv=($tn/$tes_neg)*100;
	$sen=($tp/$tot_pos)*100;
	$spe=($tn/$tot_neg)*100;
#####total samples, positive predictive value, negative predictive value, senstivity, specificity;

	$acc=(($tp+$tn)/$tot)*100;
	$num=($tp*$tn)-($fp*$fn);
	$dnum=sqrt($tot_pos*$tot_neg*$tes_pos*$tes_neg);
	$cor_coeff=$num/$dnum;
####accuracy, numerator, denominator, corelational coefficient;
       
#	$thres=sprintf"%5.2f",$thres;
#	$sen=sprintf"%6.1f",$sen;
#	$spe=sprintf"%6.1f",$spe;
#	$acc=sprintf"%6.1f",$acc;
#	$cor_coeff=sprintf"%6.2f",$cor_coeff;
# print FH2"\t$thres\t$tp\t$fn\t$fp\t$tn\t$sen\t$spe\t$acc\t$cor_coeff\n";
	if(($sen>60) && ($spe>60)){
	    open(FH2,">>RESULT");
	    #print FH2"thres\ttp\tfn\tfp\ttn\tcor_coeff\tsen\tspe\tacc\n";
	    printf FH2"%5.3f",$thres;
	    print FH2"\t$tp\t$fn\t$fp\t$tn\t";
	    printf FH2"%5.2f",$cor_coeff;
	    print FH2 "\t\t";
	    printf FH2"%5.2f",$sen;
	    print FH2 "\t";
	    printf FH2"%5.2f",$spe;
	    print FH2 "\t";
	    printf FH2"%5.2f",$acc;
	    print FH2 "\n";	
	}
    }
}
#close FH2; 

	
