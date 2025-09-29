use Getopt::Std;
getopts('p:m:o:r:');
$pos=$opt_p;
$motif=$opt_m;
$out=$opt_o;
$region=$opt_r;
open(OUT,">$out");
open(MOT,">$out.mot");
if($opt_p eq ''){
print "Program to run the MERCI_motif_locator.pl\n This programe will find the MERCI ouput motifs in New/Old dataset\nUsage: Perl run_MERCI_motif_locator.pl -p <sfasta file> -m <MERCI output motif_file> -o <Output sfasta file> \nIf you want to find these motif in perticular region please define -r <Region i.e 8:25[means search motif between residues from 8 to 25]>\n";
}
else{
	if($opt_r!=''){


	}
	else{
        open(FH,$pos);   
	@file=<FH>;
	close FH;
	foreach $pep(@file){
	chomp($pep);
	@split=split("##",$pep);
	open(TEMP,">TEMP");
	print TEMP "$split[0]\n$split[1]";
	print MOT "$split[1]\n";
	close TEMP;
	system "perl ~/progs/MERCI/MERCI_motif_locator.pl  -p TEMP  -i $motif -o RES >/dev/null";
	$ret=`grep '>' RES`;
	if($ret=~/>/){print OUT "1\n";}
	else{print OUT "0\n";}
#	if($ret=~/>/){print OUT $pep.":1\n";}
#	else{print OUT $pep.":0\n";}	
	 }
	}
}

close OUT;
close MOT;
