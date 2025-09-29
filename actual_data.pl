#!/usr/bin/perl

## To generate score files having only efficacy value of each sirna seq##

system "cut -f1 -d ' ' test_1.pat >> actual_1 ";
system "cut -f1 -d ' ' test_2.pat >> actual_2 ";
system "cut -f1 -d ' ' test_3.pat >> actual_3 ";
system "cut -f1 -d ' ' test_4.pat >> actual_4 ";
system "cut -f1 -d ' ' test_5.pat >> actual_5 ";

system "cat actual_1 actual_2 actual_3 actual_4 actual_5 >>actual_data";
system "rm actual_1 actual_2 actual_3 actual_4 actual_5";
