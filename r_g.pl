#!/usr/bin/perl
if($ARGV[0] eq ''){print 'if($ARGV[0]=~/b1/){system "perl ~/progs/run_learn.pl 2 5 0.01 1";}#binary                                                                                  
if($ARGV[0]=~/0/){system "perl ~/progs/run_learn.pl 0 1,10,100";}
if($ARGV[0]=~/1/){system "perl ~/progs/run_learn.pl 1 1,3,5";}                                                                                            
#print "hi their";g=0.01 j=5 c=1                                                                                                                           
if($ARGV[0]=~/aac/){system "perl ~/progs/run_learn.pl 1 3";} #aac                                                                                          
if($ARGV[0]=~/blsm/){system "perl ~/progs/run_learn.pl 2 1,10,100 0.01,0.1 1,5";} #blosum                                                                  
if($ARGV[0]=~/phy/){system "perl ~/progs/run_learn.pl 1 1";}#physico                                                                                       
if($ARGV[0]=~/cgr/){system "perl ~/progs/run_learn.pl 2 1,3,4,5,6,7,10 0.0001,0.001,0.005,0.01,0.05,0.1,1 1,3";}#bin                                       
if($ARGV[0]=~/bin/){system "perl ~/progs/run_learn.pl 2 0.1,0.5,1,3,5,10 0.01,0.05,0.1,0.3,0.5 1,5,10";}#bin                                               
if($ARGV[0]=~/cgw/){system "perl ~/progs/run_learn.pl 2 0.00001,0.00005,0.0001,0.0005,0.001,0.005,0.01,0.05,0.1,0.5,1,5,10 0.0001,0.005,0.001,0.01,0.05,0.1,0.5,1,10,30,50 1,3,5,10";}#bin ';}
if($ARGV[0]=~/cgw/){system "perl ~/progs/run_g.pl 2 0.000001,0.000005,0.00001,0.00005,0.0001,0.0005,0.001,0.005,0.01,0.05,0.1,0.5,1,5,10";}
