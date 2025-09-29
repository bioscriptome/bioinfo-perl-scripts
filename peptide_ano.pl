#!/usr/bin/perl
use Getopt::Std;
getopts('p:n:w:o:');
$prosrch=$opt_p;#positive lower case sfasta
$win=$opt_w;
$output=$opt_o;
if($prosrch eq ''){print '-p:File having proteins sequences to search (sfasta format)
-w:Define peptide size(11,13,15)
-o:Output file
'."\n"
}else{
    open(OUT,">$output");
    open(FP1,"$prosrch");
    @pro2srch=<FP1>;
    close FP1;
    foreach $pro2srch(@pro2srch){
       chomp($pro2srch);
       @parts= split("##",$pro2srch);
       $protein=$parts[1];
       
       for($i=0;$i<((length($protein))-$win);$i++){
          $pep=substr($protein,$i,$win);
           print OUT "$parts[0]\#$i\n$pep\n";
             
             }
       
       }
    }
