#!/usr/bin/perl

system "mkdir ../process-files";
system "mkdir ../process-files/aac";
system "mkdir ../process-files/dpc";
system "mkdir ../process-files/physiochem";
system "mkdir ../process-files/composition-transition";
system "mkdir ../process-files/aminoacidpair";
system "mkdir ../process-files/aminoacidpair/AAaac";
system "mkdir ../process-files/aminoacidpair/AAdpc";
system "mkdir ../process-files/aminoacidpair/AAphy";
system "mkdir ../process-files/aminoacidpair/get";




system "perl fasta2sfasta -i ../data/$ARGV[0] -o ../process-files/$ARGV[2]psfasta";
system "perl pro2aac -i ../process-files/$ARGV[2]psfasta -o ../process-files/aac/$ARGV[2]posaac";
system "perl fasta2sfasta -i ../data/$ARGV[1] -o ../process-files/$ARGV[2]nsfasta";
system "perl pro2aac -i ../process-files/$ARGV[2]nsfasta -o ../process-files/aac/$ARGV[2]negaac";
system "cp ../autoprogs/* ../process-files/aac/ ";
system "perl ../process-files/aac/auto.pl ../process-files/aac/$ARGV[2]posaac ../process-files/aac/$ARGV[2]negaac $ARGV[2]aac";





system "perl pro2dpc -i ../process-files/$ARGV[2]psfasta -o ../process-files/dpc/$ARGV[2]posdpc";
system "perl pro2dpc -i ../process-files/$ARGV[2]nsfasta -o ../process-files/dpc/$ARGV[2]negdpc";
system "cp ../autoprogs/* ../process-files/dpc/ ";
system "perl ../process-files/dpc/auto.pl ../process-files/dpc/$ARGV[2]posdpc ../process-files/dpc/$ARGV[2]negdpc $ARGV[2]dpc";


system "perl physicochemicalpro.pl ../process-files/$ARGV[2]psfasta ../process-files/physiochem/$ARGV[2]posphy";
system "perl physicochemicalpro.pl ../process-files/$ARGV[2]nsfasta ../process-files/physiochem/$ARGV[2]negphy";
system "cp ../autoprogs/* ../process-files/physiochem/ ";
system "perl ../process-files/physiochem/auto.pl ../process-files/physiochem/$ARGV[2]posphy ../process-files/physiochem/$ARGV[2]negphy $ARGV[2]phy";



system "perl composition-transition-get.pl ../process-files/$ARGV[2]psfasta > ../process-files/composition-transition/$ARGV[2]pget";
system "perl composition-transition-get.pl ../process-files/$ARGV[2]nsfasta > ../process-files/composition-transition/$ARGV[2]nget";
system "cp ../autoprogs/* ../process-files/composition-transition/ ";
system "perl ../process-files/composition-transition/auto.pl ../process-files/composition-transition/$ARGV[2]pget ../process-files/composition-transition/$ARGV[2]nget $ARGV[2]get";



system "perl create_aapMatrix.pl ../process-files/aac/$ARGV[2]posaac ../process-files/aac/$ARGV[2]negaac 20 ../process-files/aminoacidpair/AAaac/$ARGV[2]_AAmatrix";
system "perl calc_aap_multi.pl ../process-files/aac/$ARGV[2]posaac ../process-files/aminoacidpair/AAaac/$ARGV[2]_AAmatrix ../process-files/aminoacidpair/AAaac/$ARGV[2]_AApairaacpos";
system "perl calc_aap_multi.pl ../process-files/aac/$ARGV[2]negaac ../process-files/aminoacidpair/AAaac/$ARGV[2]_AAmatrix ../process-files/aminoacidpair/AAaac/$ARGV[2]_AApairaacneg";
system "cp ../autoprogs/* ../process-files/aminoacidpair/AAaac/ ";
system "perl ../process-files/aminoacidpair/AAaac/auto.pl ../process-files/aminoacidpair/AAaac/$ARGV[2]_AApairaacpos ../process-files/aminoacidpair/AAaac/$ARGV[2]_AApairaacneg $ARGV[2]AApairaac";



system "perl create_aapMatrix.pl ../process-files/dpc/$ARGV[2]posdpc ../process-files/dpc/$ARGV[2]negdpc 400 ../process-files/aminoacidpair/AAdpc/$ARGV[2]_AAmatrix";
system "perl calc_aap_multi.pl ../process-files/dpc/$ARGV[2]posdpc ../process-files/aminoacidpair/AAdpc/$ARGV[2]_AAmatrix ../process-files/aminoacidpair/AAdpc/$ARGV[2]_AApairdpcpos";
system "perl calc_aap_multi.pl ../process-files/dpc/$ARGV[2]negdpc ../process-files/aminoacidpair/AAdpc/$ARGV[2]_AAmatrix ../process-files/aminoacidpair/AAdpc/$ARGV[2]_AApairdpcneg";
system "cp ../autoprogs/* ../process-files/aminoacidpair/AAdpc/ ";
system "perl ../process-files/aminoacidpair/AAdpc/auto.pl ../process-files/aminoacidpair/AAdpc/$ARGV[2]_AApairdpcpos ../process-files/aminoacidpair/AAdpc/$ARGV[2]_AApairdpcneg $ARGV[2]AApairdpc";




system "perl create_aapMatrix.pl ../process-files/physiochem/$ARGV[2]posphy ../process-files/physiochem/$ARGV[2]negphy 10 ../process-files/aminoacidpair/AAphy/$ARGV[2]_AAmatrix";
system "perl calc_aap_multi.pl ../process-files/physiochem/$ARGV[2]posphy ../process-files/aminoacidpair/AAphy/$ARGV[2]_AAmatrix ../process-files/aminoacidpair/AAphy/$ARGV[2]_AApairphypos";
system "perl calc_aap_multi.pl ../process-files/physiochem/$ARGV[2]negphy ../process-files/aminoacidpair/AAphy/$ARGV[2]_AAmatrix ../process-files/aminoacidpair/AAphy/$ARGV[2]_AApairphyneg";
system "cp ../autoprogs/* ../process-files/aminoacidpair/AAphy/ ";
system "perl ../process-files/aminoacidpair/AAphy/auto.pl ../process-files/aminoacidpair/AAphy/$ARGV[2]_AApairphypos ../process-files/aminoacidpair/AAphy/$ARGV[2]_AApairphyneg $ARGV[2]AApairphy";




system "perl create_aapMatrix.pl ../process-files/composition-transition/$ARGV[2]pget ../process-files/composition-transition/$ARGV[2]nget 108 ../process-files/aminoacidpair/get/$ARGV[2]_AAmatrix";
system "perl calc_aap_multi.pl ../process-files/composition-transition/$ARGV[2]pget ../process-files/aminoacidpair/get/$ARGV[2]_AAmatrix ../process-files/aminoacidpair/get/$ARGV[2]_AApairgetpos";
system "perl calc_aap_multi.pl ../process-files/composition-transition/$ARGV[2]nget ../process-files/aminoacidpair/get/$ARGV[2]_AAmatrix ../process-files/aminoacidpair/get/$ARGV[2]_AApairgetneg";
system "cp ../autoprogs/* ../process-files/aminoacidpair/get/ ";
system "perl ../process-files/aminoacidpair/get/auto.pl ../process-files/aminoacidpair/get/$ARGV[2]_AApairgetpos ../process-files/aminoacidpair/get/$ARGV[2]_AApairgetneg $ARGV[2]AApairget";




