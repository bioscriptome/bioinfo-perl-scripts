#/usr/bin/perl
#usage perl program.pl DNAfile OUTfile
use CODON;use Pattern;
use lib "/home/nishant/progs/sub";
require "/home/nishant/progs/env";
my $progs="/home/nishant/progs/";
my $gpsr="/home/nishant/gpsr_1.0/bin/";
use strict;
use warnings;
use SUB;  
my @file_data = (  );
my $dna = '';
my $revcom = '';
my $protein = '';
my @frame=();
my $out=$ARGV[1];

#open(FBIN,'>'.$out);
my $file_eff_mot=$ARGV[0];
my $bingo="tem_bin".$out;
open(TEMP_BIN,">>$bingo");
my $bingo1="score.".$out;
open(TEMP_score,">>$bingo1");
open(FH,$file_eff_mot);
my @file_eff_mot=<FH>;
close FH;
open(SVM,">$out");
#print TEMP_BIN ;
foreach my $mot1 (@file_eff_mot){
system "rm *temp*";
						my ($efficacy,$mot)=split('\t',$mot1);
print $mot."\n";
print TEMP_score $efficacy."\n";
$mot=~s/U/T/g;
						@frame=SUB::sixframe($mot);
						#print "@frame";
                                                          my $frame=join("",@frame); #for 6 frame
#my $frame=$frame[0].$frame[1].$frame[2]; #for forward 3 frame
						
$frame=~s/[0-9]//g;
print $frame."\n";

open(TEMP,">temp");
print TEMP $frame;close TEMP;

my $gpsr_pa= $gpsr."motif2bin";
my $gpsr_pa1= $gpsr."col2svm";
system "perl $gpsr_pa -i temp -o temp_out -x y";
open(TEMP_out,"temp_out");
while(my $seq=<TEMP_out>){chomp($seq);
print TEMP_BIN $seq."\n";
}
close TEMP_out;
system "perl $gpsr_pa1 -i temp_out -o temp_svm -s $efficacy";
open(TEMP_SVM,"temp_svm");
while(my $seq=<TEMP_SVM>){
print SVM $seq;
}
 close TEMP_SVM;

			

					}

system "perl /media/data/progs/svm2Weka.pl $out >out.arff ";


