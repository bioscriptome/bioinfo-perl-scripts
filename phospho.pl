#!/usr/bin/perl
#require "/usr1/webserver/cgibin/pseapred2/PPredYeast/progs/base_env";
#require "/usr3/gpsr_1.0/includes/base_env";
if($ARGV[0] eq ''){print '$ARGV[0]=protein seq file in fasta format'."\n"}
$seqs=$ARGV[3]."/seq";
$tmp=$ARGV[3];
$model=$ARGV[4];
$progs='/usr1/webserver/cgibin/servers/ppredyeast/virsirnapred/progs';
$sym=$ARGV[2];
$id_pos="$ARGV[1].id_pos";
system "perl $progs/fasta2sfasta -i $seqs -o seq.sfasta -g $tmp";
system "dos2unix $tmp/seq.sfasta";
open(SEQ,"$tmp/seq.sfasta");
open(SIRNA,">$tmp/SIRNAS");
@array=<SEQ>;
close SEQ;
foreach $line(@array){
chomp($line);
@split=split("##",$line);
$nuc_seq=$split[1];
$nuc_seq=~s/\s//;
$nuc_seq=~tr/ACGTU/acgtt/;
for($i=1;$i<(length($nuc_seq)-17);$i++){
$sub=substr($nuc_seq,$i-1,19);
print SIRNA "$split[0]#$i 0 $sub\n";

}
}
system "cut -d ' ' -f2,3 $tmp/SIRNAS >$tmp/input.seq";
system "perl $progs/hybrid_mdttpb1440_freq.pl $tmp/input.seq $tmp/input.pat";

if($model eq "patent"){system " $progs/svm_classify $tmp/input.pat $progs/model_$model $tmp/result_score";} 
if($model eq 2){system " $progs/svm_classify $ARGV[1].pos_bin.svm $progs/model_$model $tmp/result_score";}
system "paste -d ' ' $tmp/SIRNAS $tmp/result_score >$tmp/Trace";
system "perl -pi -e '~s/#/ /' $tmp/Trace";
system "cp $tmp/Trace $tmp/Trace1";
open(SEED,">$tmp/seed");
open(TRACE,"$tmp/Trace1");
@TRACE=<TRACE>;
close TRACE;
foreach $line(@TRACE){
chomp($line);
@split_si=split(" ",$line);
$sub=substr($split_si[3],11,7);
print SEED "$sub\n";
}
system "perl $progs/thermo_stability_col.pl -i $tmp/input.seq -o $tmp/thermo.out -t c";
system "paste -d ' ' $tmp/Trace1 $tmp/thermo.out $tmp/seed >$tmp/Trace2";
#system "ls $tmp/* |grep -v \"Trace*\" |xargs rm -rf";
print " $gpsr_svm_classify_old $ARGV[1].pos_bin.svm $progs/model_$model $tmp/result_score";
#system "paste -d ',' $id_pos.mot $ARGV[3]/result_score >$ARGV[3]/result_final";
exit;
