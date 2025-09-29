#!/usr/bin/perl

## Usage: program ObservedSeqFile PredictedSeqFile resultFile

open (OBSERVED,"$ARGV[0]");  ## Observed (Experimentally known) lower case sequences in 'SFASTA format'
@observed=<OBSERVED>; close OBSERVED;

open (PREDICTED,"$ARGV[1]"); ## Predicted lower case sequences in 'SFASTA format'
open (OUT,">>$ARGV[2]");      ## Result file 

print OUT "Name\tLength\tTP\tFN\tFP\tTN\tTP(%)\tFN(%)\tFP(%)\tTN(%)\tPPP(%)\n";
$in=$ARGV[3];

$otp=$ofn=$ofp=$otn=0;

while ($line=<PREDICTED>)
{
chomp $line;
$head=$len=$seq_pred=$seq_obs="";
$line =~ />(.+?) ##(.+)/; $head=$1; 	       $seq_pred=$2;
foreach $obs(@observed)
 {
  chomp $obs;
  if ($obs =~ /$head/) { $obs =~ /.+? ##(.+)/; $seq_obs=$1;     }
 }
#print ">$head\n$seq_obs\n$seq_pred\n";
@arr_obs=@arr_pred=();
@arr_obs=split"",$seq_obs;
@arr_pred=split"",$seq_pred;

$tp=$fn=$fp=$tn=0;

for ($x=0;$x<@arr_obs;$x++)
  {
#	if (($arr_obs[$x] =~ /[a-z]/) && ($arr_pred[$x] =~ /[a-z]/)) {	$tp++; $otp++;	}
#	if (($arr_obs[$x] =~ /[a-z]/) && ($arr_pred[$x] =~ /[A-Z]/)) {  $fn++; $ofn++;  }
#	if (($arr_obs[$x] =~ /[A-Z]/) && ($arr_pred[$x] =~ /[a-z]/)) {  $fp++; $ofp++;  }
#	if (($arr_obs[$x] =~ /[A-Z]/) && ($arr_pred[$x] =~ /[A-Z]/)) {  $tn++; $otn++;  }

### code for phosphorylation (S/T/Y)

       if (($arr_obs[$x] =~ /[st]/) && ($arr_pred[$x] =~ /[st]/)) {  $tp++; $otp++;  }
       if (($arr_obs[$x] =~ /[st]/) && ($arr_pred[$x] =~ /[ST]/)) {  $fn++; $ofn++;  }
       if (($arr_obs[$x] =~ /[ST]/) && ($arr_pred[$x] =~ /[st]/)) {  $fp++; $ofp++;  }
       if (($arr_obs[$x] =~ /[ST]/) && ($arr_pred[$x] =~ /[ST]/)) {  $tn++; $otn++;  }



	
  }

$len=scalar @arr_obs;
  print $head."\t".$len."\n";
$perTp=($tp/$len)*100;
$perFn=($fn/$len)*100;
$perFp=($fp/$len)*100;
$perTn=($tn/$len)*100;
$perPpp=(($tp+$fp)/$len)*100;

printf OUT ">%s\t%d\t%d\t%d\t%d\t%d\t%6.2f\t%6.2f\t%6.2f\t%6.2f\t%6.2f\n",$head,$len,$tp,$fn,$fp,$tn,$perTp,$perFn,$perFp,$perTn,$perPpp;

#exit;
}

## calculation for Overall Accuracy and MCC
$sensitivity=$specificity=$accuracy=$k=$k1=$k2=$k3=$a=$b=$j=$j1=$mc=$mcc=0;
print OUT "\n---------------------------------------------------------------------------------------\n";print OUT "Overall Prediction\n\n";
print OUT "Thr\t \tTP\tFN\tFP\tTN\tSen\tSpe\tACC\tMCC\n";

   if (($otp>0) && ($ofn>=0)){
    $sensitivity = ($otp/($otp+$ofn))*100;
			   }
if (($otn>0) && ($ofp>=0)){
    $specificity  = ($otn/($otn+$ofp))*100;
			}
if (($otp>0) && ($otn>0)){
    $accuracy = ((($otp+$otn)/($otp+$otn +$ofp +$ofn)))*100;
    $k= $otp+$ofp;
    $k1= $otp+$ofn;
    $k2= $otn+$ofp;
    $k3= $otn+$ofn;
    $a=$k*$k1*$k2*$k3;
    $b= $a**0.5;
    $j=$otp*$otn;
    $j1= $ofp*$ofn;
    $mc=$j-$j1;
    $mcc = $mc/$b;
			}
    printf OUT "%5.1f",$in;
    print  OUT "\t \t$otp\t$ofn\t$ofp\t$otn\t";
    printf OUT "%6.2f\t",$sensitivity;
    printf OUT "%6.2f\t",$specificity;
    printf OUT "%6.2f\t",$accuracy;
    printf OUT "%6.2f\t",$mcc;
    print OUT "\n\n";

close OUT;
close PREDICTED;

