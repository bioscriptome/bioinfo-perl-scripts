open(FH,"$ARGV[0]");
@array=<FH>;
close FH;
if($ARGV[1] eq ''){$th='0.0';}else{$th=$ARGV[1];}
foreach $line(@array){
chomp($line);
@split=split("\t",$line);
if($split[2] <$th && $split[2] ne 'NA'){
if($split[0]=~/Non-AVP/ && $split[1]=~/Non-AVP/){print "$split[0]\t$split[1]\tTN\n";}
if($split[0]=~/Non-AVP/ && $split[1]=~/^AVP/){print "$split[0]\t$split[1]\tFP\n";}
if($split[0]=~/^AVP/ && $split[1]=~/Non-AVP/){print "$split[0]\t$split[1]\tFN\n";}
if($split[0]=~/^AVP/ && $split[1]=~/^AVP/){print "$split[0]\t$split[1]\tTP\n";}
if($split[0]=~/^AVP/ && $split[1]=~/NA/){print "$split[0]\t$split[1]\tFN\n";}
if($split[0]=~/Non-AVP/ && $split[1]=~/NA/){print "$split[0]\t$split[1]\tTN\n";}
}
elsif($split[0]=~/^AVP/ && $split[1]=~/^AVP/){print "$split[0]\t$split[1]\tFN\n";}
elsif($split[0]=~/^AVP/ && $split[1]=~/NA/){print "$split[0]\t$split[1]\tFN\n";}
elsif($split[0]=~/Non-AVP/ && $split[1]=~/Non-AVP/){print "$split[0]\t$split[1]\tTN\n";}
elsif($split[0]=~/Non-AVP/ && $split[1]=~/NA/){print "$split[0]\t$split[1]\tTN\n";}
elsif($split[0]=~/Non-AVP/ && $split[1]=~/^AVP/){print "$split[0]\t$split[1]\tTN\n";}
elsif($split[0]=~/^AVP/ && $split[1]=~/Non/){print "$split[0]\t$split[1]\tFN\n";}
else{print "$line hiiiiiiiiiii\n";}
#selsif($split[0]=~/^Non-AVP/ && $split[1]=~/^Non-AVP/){print "$split[0]\t$split[1]\tTN\n";}
}

__END__
if($split[2] <$th){
if($split[0]=~/Non-AVP/ && $split[1]=~/Non-AVP/){print "$split[0]\t$split[1]\tTN\n";}
if($split[0]=~/Non-AVP/ && $split[1]=~/^AVP/){print "$split[0]\t$split[1]\tFP\n";}
if($split[0]=~/^AVP/ && $split[1]=~/Non-AVP/){print "$split[0]\t$split[1]\tFN\n";}
if($split[0]=~/^AVP/ && $split[1]=~/^AVP/){print "$split[0]\t$split[1]\tTP\n";}
}
elsif($split[0]=~/^AVP/ && $split[1]=~/NA/){print "$split[0]\t$split[1]\tFN\n";}
elsif($split[0]=~/Non-AVP/ && $split[1]=~/Non-AVP/){print "$split[0]\t$split[1]\tTN\n";}
elsif($split[0]=~/Non-AVP/ && $split[1]=~/NA/){print "$split[0]\t$split[1]\tTN\n";}
elsif($split[0]=~/Non-AVP/ && $split[1]=~/^AVP/){print "$split[0]\t$split[1]\tTN\n";}
#elsif($split[0]=~/^AVP/ && $split[1]=~/^AVP/){print "$split[0]\t$split[1]\tFN\n";}
elsif($split[0]=~/^AVP/ && $split[1]=~/Non/){print "$split[0]\t$split[1]\tFN\n";}

#selsif($split[0]=~/^Non-AVP/ && $split[1]=~/^Non-AVP/){print "$split[0]\t$split[1]\tTN\n";}
}
