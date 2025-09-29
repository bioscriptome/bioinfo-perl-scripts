#!/usr/bin/perl

#### To generate five training and test sets and Main_data#;


system "cat set1 set2 set3 set4 >> train_1.pat";
system "cat set1 set2 set3 set5 >> train_2.pat";
system "cat set1 set2 set4 set5 >> train_3.pat";
system "cat set1 set3 set4 set5 >> train_4.pat";
system "cat set2 set3 set4 set5 >> train_5.pat";


system "cp set5 test_1.pat";
system "cp set4 test_2.pat";
system "cp set3 test_3.pat";
system "cp set2 test_4.pat";
system "cp set1 test_5.pat";

system "cat set5 set4 set3 set2 set1 >> Main_data";
##system "test_1.pat test_2.pat test_3.pat test_4.pat test_5.pat  >> Main_data";
