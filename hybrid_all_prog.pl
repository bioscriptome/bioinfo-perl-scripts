#open(FH,$ARGV[0]);#positive motife file
#open(FH,$ARGV[1]);#negative motife file  
$pos=$ARGV[0];
($positive,$d)=split('.',$pos);
$neg=$ARGV[1];
$win=$ARGV[2];
$neg_sfasta=$ARGV[4];
$pos_sfasta=$ARGV[3];

print $pos;
($negative,$d)=split('.',$neg);
system "perl ~/progs/motif2fasta_sfasta -i $pos -o phos_pos_$win.sfasta -s pos";
system "perl ~/progs/motif2fasta_sfasta -i $neg -o phos_neg_$win.sfasta -s pos";
print "perl ~/progs/motif2fasta_sfasta -i $pos -o phos_pos_$win.sfasta -s pos";

#system "mkdir binary aac dpc blosum pam physico";
system "perl ~/gpsr_1.0/bin/motif2bin -i $pos -o phos_pos_$win.bin -x y ";
system "perl ~/gpsr_1.0/bin/motif2bin -i $neg -o phos_neg_$win.bin -x y ";
system "perl ~/gpsr_1.0/bin/col2svm -i phos_pos_$win.bin -o phos_pos_$win.svm -s +1 ";
system "perl ~/gpsr_1.0/bin/col2svm -i phos_neg_$win.bin -o un_neg_$win.svm -s -1 ";


system "perl ~/gpsr_1.0/bin/pro2aac -i phos_pos_$win.sfasta -o phos_pos_$win.aac  ";
system "perl ~/gpsr_1.0/bin/pro2aac -i phos_neg_$win.sfasta -o phos_neg_$win.aac  ";
system "perl ~/gpsr_1.0/bin/col2svm -i phos_pos_$win.aac -o phos_pos_aac_$win.svm -s +1 ";
system "perl ~/gpsr_1.0/bin/col2svm -i phos_neg_$win.aac -o phos_neg_aac_$win.svm -s -1 ";

system "perl ~/gpsr_1.0/bin/pro2dpc -i phos_pos_$win.sfasta -o phos_pos_$win.dpc  ";
system "perl ~/gpsr_1.0/bin/pro2dpc -i phos_neg_$win.sfasta -o phos_neg_$win.dpc  ";

system "perl ~/gpsr_1.0/bin/col2svm -i phos_pos_$win.dpc -o phos_pos_dpc_$win.svm -s +1 ";
system "perl ~/gpsr_1.0/bin/col2svm -i phos_neg_$win.dpc -o phos_neg_$win.svm -s -1 ";

#system "perl ~/gpsr_1.0/bin/col2weka -i $pos -o un_pos_15.sfasta -s pos";


