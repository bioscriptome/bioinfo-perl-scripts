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
if(($split2[1] eq 'NA' && $split1[1] >0)||($split1[1] <$split2[1] && $split1[1] ne 'NA' )){print "$split1[0]\t1\t$array1[$i]\t$array2[$i]\n";}
else{print "$split1[0]\t0\t$array1[$i]\t$array2[$i]\n";}
}
}     
}

