#/usr/bin/perl
#usage perl program.pl DNAfile OUTfile
use CODON;use Pattern;
$out=$ARGV[1];
open(FBIN,'>'.$out);
$tag=$ARGV[2];
$file_eff_mot=$ARGV[0];

open(FH,$file_eff_mot);
@file_eff_mot=<FH>;
$filename="$ARGV[1]".$tag;
system "rm $filename";	open(FAA,">>$filename.aa");
foreach $mot (@file_eff_mot){
			chomp($mot);
			$aa=CODON::codon($mot);
			#open(MOT,">mot");
			#open(PAT,">pat_out");
			#open(MOT_fasta,">mot_fasta");
			#print MOT $mot;
				#open(MOT_SFASTA,'>mot_sfasta');
				#print MOT_fasta ">temp".$LINE++." ##".$mot."\n";
				#print MOT_SFASTA "$aa\n";
			#system "perl /media/data/progs/sipred/pattern_making.pl mot 2 pat_out2";
                      # system "perl /media/data/progs/sipred/pattern_making.pl mot 1 pat_out1 ";
			#system "perl /media/data/progs/sipred/pattern_making.pl mot 5 pat_out5 ";
  			#system "perl /media/data/gpsr_1.0/bin/pro2aac -i mot_sfasta -o aac";
			#system "perl /media/data/gpsr_1.0/bin/pro2dpc -i mot_sfasta -o dpc";
			#close MOT_fasta,MOT_SFASTA;
		
			#open(FAA11,'>temp1');
			#open(FAA1,'>bin');
			#open(FAA121,'>bin_temp');
			print FAA uc($aa)."\n";
			#print '.';

			#
			#open(TEMP,'temp1');@temp=<TEMP>;close FAA11;
			#foreach $print (@temp){
			#print FBIN $print;
			#}
		}close FAA,FAA1,FAA11,FAA121;
			system "perl ~/gpsr_1.0/bin/motif2bin -i $filename.aa -o $filename.bin -x y";
print "system perl ~/gpsr_1.0/bin/motif2bin -i $filename.bin -o $binary -x y";
			system "perl  ~/gpsr_1.0/bin/col2svm -i $filename.bin -o $filename.svm -s $tag";
			#system "perl /media/data/gpsr_1.0/bin/col2svm -i bin_temp -o temp1 -s $efficacy";

#system "perl /media/data/progs/svm2Weka.pl $out >out.arff ";
#system "perl /media/data/progs/sipred/make_set.pl $out ";
#system "perl /media/data/progs/sipred/svmrun_sirna.pl";


__END__
open(FB,'bin');

@bin=<FB>;
print FBIN $bin[0];close FB;
}
