$pos=$ARGV[0];
($positive,$d)=split('.',$pos);
$neg=$ARGV[1];
$win=$ARGV[2];
#$neg_sfasta=$ARGV[4];
#$pos_sfasta=$ARGV[3];
$namefile=$ARGV[3];
print $pos;
($negative,$d)=split('.',$neg);

@array=qw(1 2 3 4 5 6 );
foreach $bin(@array){
    $pos1=$pos;
    $neg1=$neg;
    $pos=$pos.$bin;
    $neg=$neg.$bin;
    print $pos."\n".$neg;
system "perl ~/progs/mot2sfasta.pl  $pos  phos_pos_$win.sfasta ";
system "perl ~/progs/mot2sfasta.pl  $neg  phos_neg_$win.sfasta ";
print "perl ~/progs/mot2sfasta.pl  $pos  phos_pos_$win.sfasta ";

    system "mkdir binary aac ./aac/$bin/";

system "perl ~/gpsr_1.0/bin/pro2aac -i phos_pos_$win.sfasta -o ./aac/phos_pos_$win.aac  ";
system "perl ~/gpsr_1.0/bin/pro2aac -i phos_neg_$win.sfasta -o ./aac/phos_neg_$win.aac  ";
system "perl ~/gpsr_1.0/bin/col2svm -i ./aac/phos_pos_$win.aac -o ./aac/phos_pos_aac_$win.svm -s +1 ";
system "perl ~/gpsr_1.0/bin/col2svm -i ./aac/phos_neg_$win.aac -o ./aac/phos_neg_aac_$win.svm -s -1 ";
system "perl ~/progs/shuffle.pl ./aac/phos_pos_aac_$win.svm ./aac/phos_neg_aac_$win.svm";
system "perl ~/progs/run.pl b1";
system "mv p_res1* ./aac/$bin/p_res1_aac";
system "mv svm_result ./aac/$bin/svm_result_aac";
system "rm train_* test_* svm_result";
    $pos=$pos1;
    $neg=$neg1;
}







