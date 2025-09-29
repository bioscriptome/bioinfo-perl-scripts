$pos=$ARGV[0];
($positive,$d)=split('.',$pos);
$neg=$ARGV[1];
$win=$ARGV[2];
#$neg_sfasta=$ARGV[4];
#$pos_sfasta=$ARGV[3];
$namefile=$ARGV[3];
print $pos;
($negative,$d)=split('.',$neg);

@array=qw(1 2 3 4 5 6 7);
foreach $bin(@array){
    $pos1=$pos;
    $neg1=$neg;
    $pos=$pos.$bin;
    $neg=$neg.$bin;
    print $pos."\n".$neg;
system "perl ~/progs/mot2sfasta.pl  $pos  phos_pos_$win.sfasta ";
system "perl ~/progs/mot2sfasta.pl  $neg  phos_neg_$win.sfasta ";
print "perl ~/progs/mot2sfasta.pl  $pos  phos_pos_$win.sfasta ";

    system "mkdir binary ./binary/$bin/";
#    system "mkdir binary aac dpc blosum pam physico run_cascade";
    system "perl ~/gpsr_1.0/bin/motif2bin -i $pos -o ./binary/phos_pos_$win.bin -x y ";
    system "perl ~/gpsr_1.0/bin/motif2bin -i $neg -o ./binary/phos_neg_$win.bin -x y ";
    system "perl ~/gpsr_1.0/bin/col2svm -i ./binary/phos_pos_$win.bin -o ./binary/phos_pos_$win.svm -s +1 ";
    system "perl ~/gpsr_1.0/bin/col2svm -i ./binary/phos_neg_$win.bin -o ./binary/phos_neg_$win.svm -s -1 ";
    system "perl ~/progs/shuffle.pl ./binary/phos_pos_$win.svm  ./binary/phos_neg_$win.svm";
    system "perl ~/progs/run.pl b1";
    system "mv p_res1* ./binary/$bin/.";
    system "mv o_res ./binary/o_res";
    system "mv svm_result ./binary/$bin/svm_result_$bin";
    $pos=$pos1;
    $neg=$neg1;
}







