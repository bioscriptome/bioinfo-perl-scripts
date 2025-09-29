open(FH,$ARGV[0]);
open(FH1,$ARGV[1]);
@array1=<FH>;
@array2=<FH1>;
close FH1;close FH2;
if($ARGV[0] eq ''){print "ARGV[0] : Positive DB Result\nARGV[1] : Negative DB Result File\n";}
else{
if(scalar(@array1) eq scalar(@array2)){
$size=scalar(@array1);
for($i=0;$i<$size;$i++){
chomp($array1[$i]);
chomp($array2[$i]);
@split1=split("\t",$array1[$i]);
@split2=split("\t",$array2[$i]);
if((($split1[0]=~/neg/) && $split1[1] eq 'NA' && $split2[1] >0)||(($split1[0]=~/neg/) && $split1[1] >=$split2[1] && $split1[1] ne 'NA')){print "$split1[0]\tTN\t$array1[$i]\t$array2[$i]\n"}
if((($split1[0]=~/pos/) && $split1[1] eq 'NA' && $split2[1] >0 )||(($split1[0]=~/pos/) && $split1[1] >$split2[1] && $split2[1] ne 'NA' && $split1[1] ne 'NA')){print "$split1[0]\tFN\t$array1[$i]\t$array2[$i]\n"}
if((($split1[0]=~/neg/) && $split2[1] eq 'NA' && $split1[1] >0)||(($split1[0]=~/neg/) && $split1[1] <$split2[1] && $split1[1] ne 'NA')){print "$split1[0]\tFP\t$array1[$i]\t$array2[$i]\n"}

if($split1[1] eq 'NA' && $split2[1] eq 'NA' && ($split1[0]=~/neg/)){print "$split1[0]\tTN\t$array1[$i]\t$array2[$i]\n"}
if($split1[1] eq 'NA' && $split2[1] eq 'NA' && ($split1[0]=~/pos/)){print "$split1[0]\tFN\t$array1[$i]\t$array2[$i]\n"}


if((($split1[0]=~/pos/) && $split2[1] eq 'NA' && $split1[1] >0)||(($split1[0]=~/pos/) && $split1[1] <=$split2[1] && $split1[1] ne 'NA')){print "$split1[0]\tTP\t$array1[$i]\t$array2[$i]\n"}

#if(($split1[0]=~/pos/) && $split1[1] eq 'NA' && $split2[1] >0){print "$split1[0]\tFN\n";}
#if($split1[1] >$split2[1]){print "$split1[0]\tpos\n";}
#if($split1[1] >$split2[1]){print "$split1[0]\tpos\n";}

#print "$array1[$i]\t$array2[$i]\n";

}

}
}

