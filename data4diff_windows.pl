use Getopt::Std;
#!/usr/bin/perl
getopts('p:n:v:m:f:w:c:');
$lc_pos=$opt_p;#positive lower case sfasta
$lc_neg=$opt_n;#negative lower case sfasta
$blind_pos=$opt_v;#blind positive lower case sfasta
$blind_neg=$opt_m;#blind negative lower case sfasta
$folder=$opt_f;#folder name to save the output
$win_arg=$opt_w;
$feature=$opt_c;#Feature names,bin,dpc,aac,db,aap etc
if($lc_pos eq ''|| $lc_neg eq ''){print '-p:positive lower case sfasta
-n:negative lower case sfasta
-v:blind positive lower case sfasta
-m:blind negative lower case sfasta
-f:folder name to save the output
-w:Define Windows size(11,13,15)
-c:Feature names,bin,dpc,aac,db,aap etc
'."\n"
}else{
if($folder eq ''){$folder='.';}else{$folder=$folder;}
#@windows=qw(11);
@windows=split(",",$win_arg);
close WIN;
$compute=0;
foreach $win(@windows){
$compute++;
#$folder=
#chdir($folder);
$path="$folder/w".$win;
print "$folder/w$win";
system "mkdir $path";
system "mkdir $path/aac";
system "mkdir $path/dpc";
system "mkdir $path/aap";
system "mkdir $path/bin";
system "mkdir $path/dpc_bin";
#system "mkdir $path/";
chomp($win);
#SFASTA
system "perl ~/progs/lc_sfasta2mot_sfasta.pl $lc_pos $win $path/t_pos\_$win.sfasta";
system "perl ~/progs/lc_sfasta2mot_sfasta.pl $lc_neg $win $path/t_neg\_$win.sfasta";
system "perl ~/progs/lc_sfasta2mot_sfasta.pl $blind_pos $win $path/tblind_pos\_$win.sfasta"; 
system "perl ~/progs/lc_sfasta2mot_sfasta.pl $blind_neg $win $path/tblind_neg\_$win.sfasta";     


#BIN
system "cut -d '#' -f3 $path/t_pos\_$win.sfasta >$path/pos.mot";
system "cut -d '#' -f3 $path/t_neg\_$win.sfasta >$path/neg.mot";
system "cut -d '#' -f3 $path/tblind_pos\_$win.sfasta >$path/bpos.mot";
system "cut -d '#' -f3 $path/tblind_neg\_$win.sfasta >$path/bneg.mot";
system "perl /home/nishant/gpsr_1.0/bin/motif2bin -i $path/pos.mot -o $path/bin/pos_bin.col -x y";
system "perl /home/nishant/gpsr_1.0/bin/motif2bin -i $path/neg.mot -o $path/bin/neg_bin.col -x y";
system "perl /home/nishant/gpsr_1.0/bin/motif2bin -i $path/bpos.mot -o $path/bin/tblind_pos_bin.col -x y";
system "perl /home/nishant/gpsr_1.0/bin/motif2bin -i $path/bneg.mot  -o $path/bin/tblind_neg_bin.col -x y";
if($feature=~/bin/){
system "perl ~/gpsr_1.0/bin/col2svm -i $path/bin/pos_bin.col -o $path/bin/pos.svm -s +1";
system "perl ~/gpsr_1.0/bin/col2svm -i $path/bin/neg_bin.col -o $path/bin/neg.svm -s -1";
system "perl ~/gpsr_1.0/bin/col2svm -i $path/bin/tblind_pos_bin.col -o $path/bin/bpos.svm -s +1";
system "perl ~/gpsr_1.0/bin/col2svm -i $path/bin/tblind_neg_bin.col -o $path/bin/bneg.svm -s -1";
system "mkdir $path/bin/run";

chdir("$path/bin/run");
system "perl ~/progs/shuffle.pl ../pos.svm ../neg.svm";
system "cat ../bpos.svm ../bneg.svm >eval_1";
system "nohup perl ~/progs/runr.pl cgw &";
}
system ("$path/aac/");
#AAC
system "perl ~/gpsr_1.0/bin/pro2aac -i $path/t_pos\_$win.sfasta -o $path/aac/pos.aac";
system "perl ~/gpsr_1.0/bin/pro2aac -i $path/t_neg\_$win.sfasta -o $path/aac/neg.aac";
system "perl ~/gpsr_1.0/bin/pro2aac -i $path/tblind_pos\_$win.sfasta -o $path/aac/tblind_pos.aac";
system "perl ~/gpsr_1.0/bin/pro2aac -i $path/tblind_neg\_$win.sfasta -o $path/aac/tblind_neg.aac";
if($feature=~/aac/){
system "perl ~/gpsr_1.0/bin/col2svm -i $path/aac/pos.aac -o $path/aac/pos.svm -s +1";
system "perl ~/gpsr_1.0/bin/col2svm -i $path/aac/neg.aac -o $path/aac/neg.svm -s -1";
system "perl ~/gpsr_1.0/bin/col2svm -i $path/aac/tblind_pos.aac -o $path/aac/bpos.svm -s +1";
system "perl ~/gpsr_1.0/bin/col2svm -i $path/aac/tblind_neg.aac -o $path/aac/bneg.svm -s -1";
system "mkdir $path/aac/run";

chdir("$path/aac/run");
system "perl ~/progs/shuffle.pl ../pos.svm ../neg.svm";
system "cat ../bpos.svm ../bneg.svm >eval_1";
system "nohup perl ~/progs/runr.pl cgw &";
}
#DPC
system ("$path/dpc/");
system "perl ~/gpsr_1.0/bin/pro2dpc -i $path/t_pos\_$win.sfasta -o $path/dpc/pos.dpc";
system "perl ~/gpsr_1.0/bin/pro2dpc -i $path/t_neg\_$win.sfasta -o $path/dpc/neg.dpc";
system "perl ~/gpsr_1.0/bin/pro2dpc -i $path/tblind_pos\_$win.sfasta -o $path/dpc/tblind_pos.dpc";
system "perl ~/gpsr_1.0/bin/pro2dpc -i $path/tblind_neg\_$win.sfasta -o $path/dpc/tblind_neg.dpc";
if($feature=~/dpc/){
system "perl ~/gpsr_1.0/bin/col2svm -i $path/dpc/pos.dpc -o $path/dpc/pos.svm -s +1";
system "perl ~/gpsr_1.0/bin/col2svm -i $path/dpc/neg.dpc -o $path/dpc/neg.svm -s -1";
system "perl ~/gpsr_1.0/bin/col2svm -i $path/dpc/tblind_pos.dpc -o $path/dpc/bpos.svm -s +1";
system "perl ~/gpsr_1.0/bin/col2svm -i $path/dpc/tblind_neg.dpc -o $path/dpc/bneg.svm -s -1";
 system "mkdir $path/dpc/run";
chdir("$path/dpc/run");
system "perl ~/progs/shuffle.pl ../pos.svm ../neg.svm";
system "cat ../bpos.svm ../bneg.svm >eval_1";
system "nohup perl ~/progs/runr.pl cgw &";
}
#AAP
system ("$path/aap/");
system "perl ~/progs/create_aapMatrix.pl $path/t_pos\_$win.sfasta $path/t_neg\_$win.sfasta 400 $path/aap/aap_matrix ";
system "perl ~/progs/calc_aap_multi.pl pos.col $path/aap/aap_matrix $path/aap/pos.aap";
system "perl ~/progs/calc_aap_multi.pl neg.col $path/aap/aap_matrix $path/aap/neg.aap";
system "perl ~/progs/calc_aap_multi.pl  $path/dpc/tblind_pos.dpc $path/aap/aap_matrix $path/aap/bpos.aap";
system "perl ~/progs/calc_aap_multi.pl  $path/dpc/tblind_neg.dpc  $path/aap/aap_matrix $path/aap/bneg.aap";
if($feature=~/aap/){
system "perl ~/gpsr_1.0/bin/col2svm -i $path/aap/pos.aap -o $path/aap/pos.svm -s +1";
system "perl ~/gpsr_1.0/bin/col2svm -i $path/aap/neg.aap -o $path/aap/neg.svm -s -1";
system "perl ~/gpsr_1.0/bin/col2svm -i $path/aap/bpos.aap -o $path/aap/bpos.svm -s +1";
system "perl ~/gpsr_1.0/bin/col2svm -i $path/aap/bneg.aap -o $path/aap/bneg.svm -s -1";
system "mkdir $path/aap/run";

chdir("$path/aap/run");
system "perl ~/progs/shuffle.pl ../pos.svm ../neg.svm";
system "cat ../bpos.svm ../bneg.svm >eval_1";
system "nohup perl ~/progs/runr.pl cgw &";
}
system ("$path/dpc_bin/");
if($feature=~/db/){
system "paste -d ',' $path/dpc/pos.dpc $path/bin/pos_bin.col > $path/dpc_bin/pos.dpc_bin";
print "paste -d ',' $path/dpc/pos.dpc $path/bin/pos_bin.col > $path/dpc_bin/pos.dpc_bin";
system "paste -d ',' $path/dpc/neg.dpc $path/bin/neg_bin.col > $path/dpc_bin/neg.dpc_bin";
system "paste -d ',' $path/dpc/tblind_pos.dpc $path/bin/tblind_pos_bin.col > $path/dpc_bin/bpos.dpc_bin";
system "paste -d ',' $path/dpc/tblind_neg.dpc $path/bin/tblind_neg_bin.col > $path/dpc_bin/bneg.dpc_bin";
system "perl ~/gpsr_1.0/bin/col2svm -i $path/dpc_bin/pos.dpc_bin -o $path/dpc_bin/pos.svm -s +1";
system "perl ~/gpsr_1.0/bin/col2svm -i $path/dpc_bin/neg.dpc_bin -o $path/dpc_bin/neg.svm -s -1";
system "perl ~/gpsr_1.0/bin/col2svm -i $path/dpc_bin/bpos.dpc_bin -o $path/dpc_bin/bpos.svm -s +1";
system "perl ~/gpsr_1.0/bin/col2svm -i $path/dpc_bin/bneg.dpc_bin -o $path/dpc_bin/bneg.svm -s -1";
system "mkdir $path/dpc_bin/run";
chdir("$path/dpc_bin/run");
system "perl ~/progs/shuffle.pl ../pos.svm ../neg.svm";
system "cat ../bpos.svm ../bneg.svm >eval_1";
system "nohup perl ~/progs/runr.pl cgw &";
}
#system "rm -rf $path/*.sfasta $path/*.aap $path/*.dpc";
#system "mkdir $path/run";
#system "cat $path/bpos.svm  $path/bneg.svm >$path/run/eval_1";
#$pwd=`pwd`;
#print $pwd;
#chdir("$path/run");
#`ssh compute$compute[$compute]`;
#chdir("$path/run");
#system "perl ~/progs/shuffle.pl ../pos.svm ../neg.svm";
#system "nohup perl ~/progs/runr.pl cgw &";


#system "ls $path/bin/* |grep -v *.* |rm -rf *";
#system "ls  $path/aac/* |grep -v *.* |rm -rf *";
#system "ls  $path/aap/* |grep -v  *.* |rm -rf *";
#system "ls  $path/dpc/* |grep -v *.* |rm -rf *";
}
}
