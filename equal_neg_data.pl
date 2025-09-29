if($ARGV[0] eq ''||$ARGV[1] eq ''||$ARGV[2] eq ''||$ARGV[3] eq ''){print "ARGV[0]: id_pos_sfasta file\nARGV[1]: number of sites\nARGV[2]: ADD_more_number\nARGV[3]: Output file\n"; }
else{open(FH,$ARGV[0]);
open(TEMP,">TEMPPPP");
@array=<FH>;
close FH;
foreach $line(@array){
@split=split("##",$line);
@split1=split("\t",$split[1]);
foreach $line1(@split1){ chomp($line1);if($line1 ne ''){print TEMP $split[0]."\t".$line1."\n";}}
}
close TEMP;
system "perl ~/progs/createRandomSeq_eq.pl TEMPPPP $ARGV[1] TEMP_1 $ARGV[2]";
system "wc -l TEMP_1";
system "cut -f1 TEMP_1|sed 's/>//g' |sort -u |grep \"[A-Za-z0-9]\">uniqu_id";
system "perl  ~/progs/phosphorylation_sites_with_id.pl TEMP_1 uniqu_id ooooooo";
system "mv ooooooo $ARGV[3]";
system "rm TEMP_1 TEMPPPP uniqu_id ";
}
