#!/usr/perl/bin -w
#seprating sequences acc to the length of sirna sequence
#usage perl prog.pl file_eff_seq.txt output_file_name
#use lib "/home/nishant/progs/sub";
#use SUB;
open(FH,$ARGV[0]);
open(FA,">$ARGV[0]"."_AS");
@eff_seq=<FH>;
close FH;

foreach $eff_seq(@eff_seq){
		chomp($eff_seq);

		($eff,$seq)=split(" ",$eff_seq);
		$seq=~tr/uU/tt/;
		$revseq=  reverse($seq);
		$revseq =~ tr/ACGTacgt/TGCAtgca/;
                 print FA $eff." ".$revseq."\n"; 
}

		
