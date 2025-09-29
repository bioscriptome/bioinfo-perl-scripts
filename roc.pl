#!/usr/bin/perl

$file1=$ARGV[0];
$file2=$ARGV[1];
$file3=$ARGV[2];
open(DAG,">>$file3");
system "cut -d ' ' -f1 $file1 >fcol-class"; 
$roc=`./perf -roc -files fcol-class $ARGV[1]`;
                @auc=split"    ",$roc;
               # print DAG "$auc[0]\t";
               print DAG "AUC = ";
                printf DAG "%3.2f\n",$auc[1];
system "rm fcol-class";
close DAG;
