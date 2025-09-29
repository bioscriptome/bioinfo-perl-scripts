#!/usr/bin/perl
#require "/usr1/webserver/cgibin/pseapred2/PPredYeast/progs/base_env";
require "/usr3/gpsr_1.0/includes/base_env";
if($ARGV[0] eq ''){print '$ARGV[0]=protein seq file in fasta format'."\n"}
$seqs=$ARGV[3]."/seq";
$tmp=$ARGV[3];
print $seqs."hi";
#open(SEQ,">$seqs");
#print SEQ ">name\n$ARGV[0]";close SEQ;
#system "chmod -R 777 $tmp";
print "hi thr";
$progs='/usr1/webserver/cgibin/ppredyeast/progs';
$sym=$ARGV[2];
$id_pos="$ARGV[1].id_pos";
system "perl $progs/fasta2sfasta -i $seqs -o seq.sfasta -g $tmp";
system "dos2unix $tmp/seq.sfasta";

system "perl $progs/inverse_lc_sfasta_file_blind_all.pl $tmp/seq.sfasta $tmp/seq.lc 2000000000";

system "perl $progs/sfasta_lc_2_id_seq_sfasta.pl $tmp/seq.lc $id_pos";

system "perl $progs/run_VSL2_server.pl $tmp/seq.lc $id_pos 15 $tmp";

#system "perl $progs/calcPhysicoChemical.pl ~/Matrix/physico/Matrix_14_properities_col_2000_pos_same.mtx $id_pos.mot  $ARGV[1].physico";
#system "perl $progs/col2svm -i $ARGV[1].physico -o $ARGV[1].physico.svm -s +1";
#system "perl $progs/svm2Weka.pl $ARGV[1].physico.svm $ARGV[1].physico.arff ";
system "perl $progs/motif2bin -i $id_pos.mot -o $id_pos.bin -x y ";

system "paste -d ' '  $id_pos.DIS $id_pos.bin.bin >$id_pos.pos_bin ";
system "perl $progs/col2svm_bin -i $id_pos.pos_bin -o $ARGV[1].pos_bin.svm -s $sym";
system " $gpsr_svm_classify_old $ARGV[1].pos_bin.svm $progs/model_test $tmp/result_score"; 
system "paste -d ',' $id_pos.mot $ARGV[3]/result_score >$ARGV[3]/result_final";
print "paste -d '@' $id_pos.mot $ARGV[3]/result_score >$ARGV[3]/final\n";
