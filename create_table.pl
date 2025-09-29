#!/usr/bin/perl
#################  This program Creates Table of all parameters as count of TP,TN,MCC,Thresold etc.Takes two files as input o#one is(o_res) Observerd values (+/-) obtained from catenating all test sets and other file (p_res)is catenated from result 
### of svm_classify#  #######
		
		$f1=$ARGV[0];
                $f2=$ARGV[1];
                open(FILE1,$f1) or die "Cannot open file $f1";
                open (FILE2,$f2) or die "Cannot open file $f2";
                @o=<FILE1>;
                @p=<FILE2>;
                chomp (@o);  chomp (@p);
                #print "***@o\t@p^^^\n";
                $size=@p; # size of array @p or @a as both are equal no of patterns or lines
                #$cnt=0;

		open (OUT,">>svm_result") or die "cannot open";
                print OUT"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\n";
                print OUT"Thr\tTP\tFP\tFN\tTN\t SN\tSP\tACC\tMCC\n";
                print OUT"---------------------------------------------------------------------------\n";
                #$f1="o_res";
                for($in= 0;$in<=0.5;$in+= 0.1)
                  	{
                         $tp=$fp=$tn=$fn=0;
                         $sensitivity=$specificity=$accuracy=$k=$k1=$k2=$k3=$a=$b=$j=$j1=$mc=$mcc=0;
                         &calculate;  # Calling subrutine 'calculate' Dont worry it ll work
                  	}
                 for ($in=0.6;$in<=1;$in+= 0.1)
			{
                          $tp=$fp=$tn=$fn=0;
                          $sensitivity=$specificity=$accuracy=$k=$k1=$k2=$k3=$a=$b=$j=$j1=$mc=$mcc=0;
                   	  &calculate; # Calling subrutine 'calculate' Dont worry it ll work
                  	}

sub calculate {
                 # $cnt++;
                # $tp=$fp=$tn=$fn=0;
                # $sensitivity=$specificity=$accuracy=$k=$k1=$k2=$k3=$a=$b=$j=$j1=$mc=$mcc=0;
                # if($cnt == 12){ $in = "-0.1";}
                     for ($i=0;$i<$size;$i++)
                         {
                           if($o[$i]=~/\+/)   # This is symbol present in o_res file for a particular pattern for +ive test
                             {
                              if($p[$i] >= $in)   { $tp++ }
                              elsif($p[$i] < $in) { $fn++ }
                             }
                           elsif($o[$i]=~/-/) # This is symbol present in o_res file for a particular pattern for -ive test
                             {
                               if($p[$i] <= $in) {$tn++}
                               elsif($p[$i]>$in) {$fp++}
                             }
                         }  
   if (($tp>0) && ($fn>=0)){
   # $sensitivity=$specificity=$accuracy=$k=$k1=$k2=$k3=$a=$b=$j=$j1=$mc=$mcc=0;
    $sensitivity = ($tp/($tp+$fn))*100;}
if (($tn>0) && ($fp>=0)){
    $specificity  = ($tn/($tn+$fp))*100;}
if (($tp>0) && ($tn>0)){
    $accuracy = ((($tp+$tn)/($tp+$tn +$fp +$fn)))*100;
    $k= $tp+$fp;
    $k1= $tp+$fn;
    $k2= $tn+$fp;
    $k3= $tn+$fn;
    $a=$k*$k1*$k2*$k3;
    $b= $a**0.5;
    $j=$tp*$tn;
    $j1= $fp*$fn;
    $mc=$j-$j1;
    $mcc = $mc/$b;
}
    printf OUT "%5.1f",$in;
    print  OUT "\t$tp\t$fp\t$fn\t$tn\t";
    printf OUT "%6.2f\t",$sensitivity;
    printf OUT "%6.2f\t",$specificity;
    printf OUT "%6.2f\t",$accuracy;
    printf OUT "%6.2f\t",$mcc;
    print OUT "\n";
               }
close (OUT);




