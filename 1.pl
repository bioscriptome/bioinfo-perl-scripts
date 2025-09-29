#!/usr/bin/perl
open(FH,"2.txt");
while($line=<FH>){
for (my $key = 0; $key < length($line); $key+=2) {
print substr ($line, $key, 8)."\n";
}}
