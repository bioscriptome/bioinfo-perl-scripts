#!/usr/bin/perl 
use Multi_index;
$str="ABCDEFGHIJKLABCDMNOPQRSTABCDUVWXYZABCDGGGGGDABCD";
$mot='ABCD';
@out=multi_index($str,$mot);
 print @out;
