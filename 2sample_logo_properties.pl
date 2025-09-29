open(FH,$ARGV[0]);#motifile
@motif=<FH>;
close FH;
open(CHARG,">".$ARGV[1].".CHRG");
open(HYD,">".$ARGV[1].".HYD");
open(SE,">".$ARGV[1].".SE");
open(FLX,">".$ARGV[1].".FLX");
open(DO,">".$ARGV[1].".DO");
open(CHHYD,">".$ARGV[1].".CH_HYD");
open(SEFLXDO,">".$ARGV[1].".SE_FLX_DO");


foreach $motif (@motif){
if($motif!=~/>/){
chomp($motif);
@seq=split("",$motif);
$PCR=0;$NCR=0;$NUR=0;
$HYDP=0;$NHYDP=0;
$SE=0;$BR=0;
$HFR=0;$LFR=0;
$DPR=0;$OPR=0;$NPR=0;
$len_mot=length($motif);
foreach $seq(@seq){
if($seq=~/[KRH]/){$PCR++;}
if($seq=~/[DE]/){$NCR++;}
if($seq=~/[NPQSACFGILMTVWY]/){$NUR++;}
if($seq=~/[AFGILPVWY]/){$HYDP++;}
if($seq=~/[NQSCMTDEKRH]/){$NHYDP++;}
if($seq=~/[DEHKNPQRSTY]/){$SE++;}
if($seq=~/[ACFGILMVW]/){$BR++;}
if($seq=~/[DEKNPQRS]/){$HFR++;}
if($seq=~/[ACFGHILMTVWY]/){$LFR++;}
if($seq=~/[ARSQEGKP]/){$DPR++;}
if($seq=~/[NCILFWYV]/){$OPR++;}
if($seq=~/[DHMT]/){$NPR++;}
}
$PCR1=($PCR*10)/$len_mot;
$NCR1=($NCR*10)/$len_mot;
$NUR1=($NUR*10)/$len_mot;
$HYDP1=($HYDP*10)/$len_mot;
$NHYDP1=($NHYDP*10)/$len_mot;
$SE1=($SE*10)/$len_mot;
$BR1=($BR*10)/$len_mot;
$HFR1=($HFR*10)/$len_mot;
$LFR1=($LFR*10)/$len_mot;
$DPR1=($DPR*10)/$len_mot;
$OPR1=($OPR*10)/$len_mot;
$NPR1=($NPR*10)/$len_mot;
print CHARG $PCR1.",".$NCR1.",".$NUR1."\n";
print HYD $HYDP1.",".$NHYDP1."\n";
print SE $SE1.",".$BR1."\n";
print FLX $HFR1.",".$LFR1."\n";
print DO $DPR1.",".$OPR1.",".$NPR1."\n";
print CHHYD $PCR1.",".$NCR1.",".$NUR1.",".$HYDP1.",".$NHYDP1."\n";
print SEFLXDO $SE1.",".$BR1.",".$HFR1.",".$LFR1.",".$DPR1.",".$OPR1.",".$NPR1."\n";

}
}

__END__

Charge
Positively charged residues (KRH) are colored blueand negatively charged residues (DE) are colored red; all neutral residues are colored black.
Hydrophobicity
Hydrophobic residues (AFGILPVWY) are cyan coloredwhile the remaining hydrophilic residues are colored black. This classification was based on (Eisenberg1984).
Surface exposure
Surface exposed residues (DEHKNPQRSTY) are colored orangeand burried residues (ACFGILMVW) are colored black. This classification was based on (Janin1979).
Flexibility
High flexibility residues (DEKNPQRS) are colored redwhereas low flexibility residues (ACFGHILMTVWY) are colored green. This classification was based on (Vihinen et al.1994).
Disorder
Disorder-promoting residues (ARSQEGKP) are colored redorder-promoting residues (NCILFWYV) are colored blueand disorder-order neutral residues (DHMT) are colored black. This classification was based on (Dunker et al.2001).
