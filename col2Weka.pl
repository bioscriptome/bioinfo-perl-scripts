#!/usr/bin/perl
#=================================================================
# program developed for generating Weka ARFF format
# Usage: program col_file symbol
#=================================================================
use Getopt::Std;
getopts('i:j:o:s:p:');

$file1=$opt_i;
$file=$opt_j;
$file2=$opt_o;
$sym=$opt_s;
$sym1=$opt_p;
#--------------------------------------------------------------
if(($opt_i eq '')||($opt_s eq ''))
{
    print "-i\tFeature in column seprated format (Positive data)\n";
    print "-j\tFeature in column seprated format (Negative data)\n";
    print "-o\tOutput file name\n";
    print "-s\t Symbol 1/Positive/Yes for positive set\n";
    print "-p\t Symbol 0/Negative/No for negative set\n";
    print "Usage: col2Weka -i Poscol_file -j Negcol_file -s Postag -p NegTag -o Arffoutput\n";
    print "Usage for displaying on screen: col2svm col_file symbol \n";
    exit;
}
#=================================================================

if(($opt_i ne '')&& ($opt_o ne '') &&($opt_s ne '')){
open(FP1,"$file1");
open(FP2,">$file2");
#while($t1=<FP1>){
#    chomp($t1);

open(FP1,"$file1");print FP2 "@"."RELATION $file1\_$file\n\n";
while($t1=<FP1>){
    chomp($t1); 
    if(index($t1,"#") != 0){
#	@t2 = split(",",$t1);
	@t2=split",",$t1;	
    			   }
		}
for($i=1;$i<=@t2;$i++)
{
    print FP2 "@"."ATTRIBUTE F$i REAL\n";
}
print FP2 "@"."ATTRIBUTE class\t{$sym,$sym1}\n\n";
print FP2 "@"."DATA\n";
close FP1;


open(FP1,"$file1");
while($t1=<FP1>){
    chomp($t1); 
    if(index($t1,"#") != 0){
    @ti = split(",",$t1);
    $count = 0;
    
    foreach(@ti){
	$c2 = $_;
	$count++;
	printf (FP2 "%5.3f,",$c2);
		}
    print FP2 "$sym ";
    print FP2 "\n";
			   }
		}
close FP1;
open(FP3,"$file");
while($n1=<FP3>){
    chomp($n1); 
    if(index($n1,"#") != 0){
    @tn = split(",",$n1);
    $count = 0;
    
    foreach(@tn){
	$cn = $_;
	$count++;
	printf (FP2 "%5.3f,",$cn);
		}
    print FP2 "$sym1 ";
    print FP2 "\n";
		           }
		 }
#}
close FP3;
}
__END__
exit();
}if(($opt_i ne '') &&($opt_s ne '')){
open(FP1,"$file1");print "@"."RELATION $file1\n\n";
while($t1=<FP1>){
    chomp($t1); 
    if(index($t1,"#") != 0){
	@t2 = split(",",$t1);
    }
}
for($i=1;$i<=@t2;$i++)
{
    print "@"."ATTRIBUTE F$i REAL\n";
}
print "@"."ATTRIBUTE class\t{$sym,$sym1}\n\n";
print "@"."DATA\n";
close FP1;
open(FP1,"$file1");
while($t1=<FP1>){
    chomp($t1); 
    if(index($t1,"#") != 0){
    @ti = split(",",$t1);
    $count = 0;
    
    foreach(@ti){
	$c2 = $_;
	$count++;
	printf("%5.3f,",$c2);
    }
    print "$sym ";
    print "\n";
}
}
close FP1;
open(FP3,"$file");
while($n1=<FP3>){
    chomp($n1); 
    if(index($n1,"#") != 0){
    @tn = split(",",$n1);
    $count = 0;
    
    foreach(@tn){
	$cn = $_;
	$count++;
	printf("%5.3f,",$cn);
    }
    print "$sym1 ";
    print "\n";
}
}
close FP3;
}
# Developed by G P S Raghava on 10 Jan 2009
