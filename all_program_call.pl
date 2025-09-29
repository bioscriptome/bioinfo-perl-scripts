#/usr/bin/perl
#usage perl program.pl DNAfile OUTfile
use CODON;use Pattern;
$file_eff_mot=$ARGV[0];
$out=$ARGV[1];
$motif_file=$ARGV[2];
$feature=$ARGV[3];
open(MOT_fasta,">mot_fasta");
open(AA,'>'.$motif_file);
open(FBIN,'>'.$out);
open(FH,$file_eff_mot);
open(AA1,'>AA_sfasta');
open(EFF,'>efficacy');
open(ntc,'>ntc');
open(SVM,'>svm');
open(dnc,'>dnc');$tnc="tnc";$tnc_out="tnc_out";
#open(tnc,'>tnc');
@file_eff_mot=<FH>;
$LINE=1;
foreach $mot1 (@file_eff_mot){
	($efficacy,$mot)=split('\t',$mot1);
	print EFF $efficacy."\n";
	chomp($mot);
	$aa=CODON::codon($mot);
	print  AA $aa."\n";
        print MOT_fasta ">temp".$LINE++." ##".$mot."\n";
	print AA1 ">temp".($LINE-1)."##".$aa."\n";
       # $ntc=Pattern::nc($mot,length($mot));
       # @PAT=split(",",$ntc);
 	print ".";
       # printf ntc ("%2.2f,",$PAT[0]); printf ntc ("%2.2f,",$PAT[1]); printf ntc ("%2.2f,",$PAT[2]); printf ntc ("%2.2f",$PAT[3]);print ntc "\n";
       # print dnc (Pattern::dinuc($mot))."\n";
#####################################################
        if($feature == '1'){
        open(COL,">col");
	$ntc=Pattern::nc($mot,length($mot));
	@PAT=split(",",$ntc);
 	print ".";
        printf COL ("%3.2f,",$PAT[0]); printf COL ("%3.2f,",$PAT[1]); printf COL ("%3.2f,",$PAT[2]); printf COL ("%3.2f",$PAT[3]);print ntc "\n";
        close COL;
        system "perl ~/gpsr_1.0/bin/col2svm -i col -o svm -s $efficacy";close SVM;}

#####################################################
        if($feature == '2'){
        open(COL,">col");
        print COL (Pattern::dinuc($mot))."\n";close COL;
        system "perl ~/gpsr_1.0/bin/col2svm -i col -o svm -s $efficacy";close SVM;}
 

#####################################################
        if($feature == '3'){
         open(COL,">col");
        system "perl /home/nishant/progs/sipred_progs/compo_trint.pl mot_fasta tnc";
	open(TNC,'>tnc_temp');
        print COL (Pattern::dinuc($mot))."\n";close COL;
        system "perl ~/gpsr_1.0/bin/col2svm -i col -o svm -s $efficacy";close SVM;}
  open(TEMP,'svm');@temp=<TEMP>;
  foreach $print (@temp){
  print FBIN $print;
  }
close TEMP;
}



system "perl ~/progs/svm2Weka.pl SVM >out.arff ";
system "perl /home/nishant/progs/sipred_progs/make_set.pl $out ";
system "perl /home/nishant/progs/sipred_progs/svmrun_sirna.pl";




    
			system "perl ~/gpsr_1.0/bin/motif2bin -i $motif_file -o bin -x y";
if($pattern =='1'){ system "perl ~/gpsr_1.0/bin/nuc2nac -i AA_sfasta -o ntc1";}
if($pattern =='2'){ system "paste -d ' ' efficacy dnc >";}

close FAA,FAA1,FAA11,FAA121;close AA,AA1;













__END__

			#open(MOT,">mot");
			#open(PAT,">pat_out");
			#print MOT $mot;
			#system "perl /media/data/progs/sipred/pattern_making.pl mot 1 pat_out";
			#print FBIN $efficacy."\t";
			#open(FAA,'>temp');
			open(FAA11,'>temp1');
			open(FAA1,'>bin');
			#open(FAA121,'>bin_temp');
			#print FAA uc($aa);
			#print $aa;
			system "perl /media/data/gpsr_1.0/bin/motif2bin -i $ARGV[2] -o bin -x y";
#system "paste -d ', ' bin pat_out >bin_temp";
                        
                        system "perl /media/data/gpsr_1.0/bin/nuc2nac -i temp_fasta -o ntc";
                        system "paste -d ', ' bin temp_fasta >temp_out";
system "perl /media/data/gpsr_1.0/bin/col2svm -i temp_out -o temp1 -s $efficacy";

open(TEMP,'temp1');@temp=<TEMP>;close FAA11;
foreach $print (@temp){
print FBIN $print;

}}

system "perl /media/data/progs/svm2Weka.pl $out >out.arff ";
system "perl /media/data/progs/sipred/make_set.pl $out ";
system "perl /media/data/progs/sipred/svmrun_sirna.pl";


__END__
open(FB,'bin');

@bin=<FB>;
print FBIN $bin[0];close FB;
}
