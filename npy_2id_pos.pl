if($ARGV[0] eq ''){print '$ARGV[0]:netphosyeast server output file';}
else{ 
@num=qw(0 1 3 5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95 97 99);
foreach $num(@num){
	open(FO,$ARGV[0]);
	$seq_sfasta=$ARGV[2];
$id_pos=$ARGV[1].$num;
$final="$ARGV[1].$num.sites";
	open(FA,">$id_pos");
	$name="$ARGV[1].$num.score";
	open(FA2,">$name");
	#	$sp=$ARGV[2];
	$sp=$num;
	@array=<FO>;close FO;
	$um=0;
@ums=();
undef @ums;
	foreach $line(@array){chomp($line);

		if($line=~/^#/){
			# P17695                  94 S   MSNGSEIQD   0.601   main       YES
			if($line=~/#\s+([A-Za-z0-9\-]+)\s+(\d+)\s+[ST]+\s+[A-Za-z\-]+\s+([\d\.]+)\s+[A-Za-z]+/){
					$sp1=$sp/100;
					if($3 ge $sp1){print  FA2 $1."\t".$2."\t".$3."\n";
						$ums[$um++]= $1."\t".$2."\t".$3;
print $um."\n";
						print  FA $1."\t".$2."\n";
						print   $1."\t".$2."\t";
					print $sp1."\t$3\t$4\n";
							}
					}
		 	 }
 	 	}
	close FA,FA2;
	open(FN,">unique_id");#print "$ARGV[1]\.score\n";
	$i=0;@id=();
	foreach $line(@ums){chomp($line);($id,$pos,$score)=split("\t",$line);$id[$i++]=$id;}
		my %seen =() ;
		@unique_id = grep { ! $seen{$_}++ } @id ; 
		foreach $uid(@unique_id){print FN $uid."\n";}
print "perl /home/nishant/progs/phosphorylation_sites_with_id.pl  $id_pos unique_id  $final";
system "perl /home/nishant/progs/phosphorylation_sites_with_id.pl  $id_pos unique_id  $final";		
		close FN;
$sfasta=$ARGV[1]."_lc_$num.sfasta";
system " perl ~/progs/Binding_residue_from_uppe2lower.pl $final $seq_sfasta $sfasta";		 
	system " perl ~/progs/compare_lowerSeqs.pl $seq_sfasta $sfasta result_$num";
            
			}
}

