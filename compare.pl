#!/usr/bin/perl -W
 
open F1, "$ARGV[0]";
open F2, "$ARGV[1]";
open FA, ">$ARGV[2]";
open FA1, ">$ARGV[3]";
  
my %hash1;
my %hash2;
 
while (<F1>) { $hash1{$_} = 1; }
while (<F2>) { $hash2{$_} = 1; }
foreach (keys %hash1) { print FA if !defined($hash2{$_}); }
foreach (keys %hash2) { print  FA1 "" if !defined($hash1{$_}); }
close F1;
close F2;
