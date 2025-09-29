perl -n -e '$seq=$_;chomp($_);@split=split("##",$seq);$len=length($split[1]);print "$split[0]\t$len\n"; ' ../direct_positive_624.sfasta
