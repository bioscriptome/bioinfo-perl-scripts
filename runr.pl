#!/usr/bin/perl
#system "perl /media/data/progs/run_learn_eval.pl 0 1,10,100";
#system "perl /media/data/progs/run_learn_eval.pl 1 1,3,5 ";
#print "hi their"; g=0.1 j=10 c=10
#g=0.01 j=1 c=10
if($ARGV[0]=~/2/){system "perl ~/progs/run_learn_t2_only_test.pl 2 0.1,1,5,10 0.01,0.1,1,2,5 1,3,5,10";}#g=0.1 j=5 c=1
if($ARGV[0]=~/bin/){system "perl ~/progs/run_learn_t2_only_test.pl 2 10 0.01,0.1 1";}#comp2479 neg_same_prot_10-12-10 /c=10 g=0.01 j=1 and prev=10 0.1 10
#if($ARGV[0]=~/bin/){system "perl ~/progs/run_learn_t2_only_test.pl 2 5 0.01 1 ";}#g=0.01 j=1 c=5 eval neg sep protein
#if($ARGV[0]=~/bin/){system "perl ~/progs/run_learn_t2_only_test.pl 2 1 0.05 1 ";}# g=0.05 j=1 c=1 43 proteins
#if($ARGV[0]=~/bin/){system "perl ~/progs/run_learn_t2_only_test.pl 2 10 0.01 1 ";} #g=0.01 j=1 c=10  ppredyeast neg pos same protein on 200
if($ARGV[0]=~/1/){system "perl ~/progs/run_learn_t1_only_test.pl 1 1,3,5";}
if($ARGV[0]=~/phy/){system "perl ~/progs/run_learn_t1_only_test.pl 1 1";}
if($ARGV[0]=~/blsm/){system "perl ~/progs/run_learn_t2_only_test.pl 2 1,3,5 0.1 1,3,5";}
if($ARGV[0]=~/aac/){system "perl ~/progs/run_learn_t1_only_test.pl 1 3";}#aac blsm
#system "perl ~/progs/run_learn_t1_only_test.pl 1 5";#physico
