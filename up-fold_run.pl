#!/usr/bin/perl
if($ARGV[0] eq ''){print 'if($ARGV[0]=~/b1/){system "perl ~/progs/uprun_learn.pl 2 5 0.01 1";}#binary                                                                                  
if($ARGV[0]=~/0/){system "perl ~/progs/uprun_learn.pl 0 1,10,100";}
if($ARGV[0]=~/1/){system "perl ~/progs/uprun_learn.pl 1 1,3,5";}                                                                                            
#print "hi their";g=0.01 j=5 c=1                                                                                                                           
if($ARGV[0]=~/aac/){system "perl ~/progs/uprun_learn.pl 1 3";} #aac                                                                                          
if($ARGV[0]=~/blsm/){system "perl ~/progs/uprun_learn.pl 2 1,10,100 0.01,0.1 1,5";} #blosum                                                                  
if($ARGV[0]=~/phy/){system "perl ~/progs/uprun_learn.pl 1 1";}#physico                                                                                       
if($ARGV[0]=~/cgr/){system "perl ~/progs/uprun_learn.pl 2 1,3,4,5,6,7,10 0.0001,0.001,0.005,0.01,0.05,0.1,1 1,3";}#bin                                       
if($ARGV[0]=~/bin/){system "perl ~/progs/uprun_learn.pl 2 0.1,0.5,1,3,5,10 0.01,0.05,0.1,0.3,0.5 1,5,10";}#bin                                               
if($ARGV[0]=~/cgw/){system "perl ~/progs/uprun_learn.pl 2 0.00001,0.00005,0.0001,0.0005,0.001,0.005,0.01,0.05,0.1,0.5,1,5,10 0.0001,0.005,0.001,0.01,0.05,0.1,0.5,1,10,30,50 1,3,5,10";}#bin ';}
#if($ARGV[0]=~/b1/){system "perl ~/progs/uprun_learn.pl 2 10 0.01 1";}#binary g=0.1 j=1 c=1 g=0.1 j=1 c=0.8
if($ARGV[0]=~/0/){system "perl ~/progs/uprun_learn.pl 0 1,10,100";}
if($ARGV[0]=~/1/){system "perl ~/progs/uprun_learn.pl 1 1,3,5";}
#print "hi their";g=0.01 j=5 c=1 
if($ARGV[0]=~/aac/){system "perl ~/progs/uprun_learn.pl 1 3";} #aac
if($ARGV[0]=~/blsm/){system "perl ~/progs/uprun_learn.pl 2 1,10,100 0.01,0.1 1,5";} #blosum
if($ARGV[0]=~/phy/){system "perl ~/progs/uprun_learn.pl 1 1";}#physico
if($ARGV[0]=~/cgr/){system "perl ~/progs/uprun_learn.pl 2 1,3,4,5,6,7,10 ,0.01,0.05,0.1,1 1,3";}#bin                           
if($ARGV[0]=~/bin/){system "perl ~/progs/uprun_learn.pl 2 0.1,0.5,1,3,5,10 0.01,0.05,0.1,0.3,0.5 1,5,10";}#bin
#if($ARGV[0]=~/cgw/){system "perl ~/progs/uprun_learn.pl 2 0.001,0.005,0.05,0.1,0.5,1,5 0.001,0.005,0.01,0.05,0.1,0.5,1,10 1";}#bin                
if($ARGV[0]=~/cgw/){system "perl ~/progs/uprun_learn.pl 2 0.0005,0.001,0.005,0.01,0.05,0.1,0.5,1,5,10 0.0001,0.005,0.001,0.01,0.05,0.1,0.5,1,10,30,50 1";}
if($ARGV[0]=~/cgl/){system "perl ~/progs/uprun_learn.pl 2 1,5,10,50,100,500 0.00000001,0.00000005,0.0000001,0.0000005,0.000001,0.000005,0.00001,0.00005,0.0001,0.0005,0.001,0.005,0.01,0.05,0.1,0.5 1";}#bin                                       
if($ARGV[0]=~/bpl/){system "perl ~/progs/uprun_learn.pl 2 0.8,1,5,8,9,10 0.1 1";}  #g=0.1 j=1 c=1 #g=0.1 j=1 c=0.8.
if($ARGV[0]=~/bpf/){system "perl ~/progs/uprun_learn.pl 2 0.1 0.1 1";}  #g=0.1 j=1 c=1 #g=0.1 j=1 c=0.8.

if($ARGV[0]=~/comp/){system "perl ~/progs/uprun_learn.pl 2 0.05,0.07,0.08,0.1,0.3,0.5,0.8,1,3  5 1";}  #g=0.1 j=1 c=1 #g=0.1 j=1 c=0.8.
