#!/usr/bin/perl 
use Getopt::Std;
getopts('i:o:');

$file1=$opt_i;
$file2=$opt_o;

#---------------------------------------------------------------#
#print "$file1 $file2\n";
if($opt_i eq '')
{
    print "USAGE: apro2aac1.pl -i <i/p file> -o <mode>\n";
    print "-i\tSequence in sFASTA format\n";
    print "-o\tout put file\n";
    exit();
}
#---------------------------------------------------------------#
$aa = "#ACDEFGHIKLMNPQRSTVWYX";
if(($opt_i ne '')&& ($opt_o ne ''))
{
    open(FP1,"$file1");
    open(FP2,">$file2");
    while($t1=<FP1>){
	chomp($t1);
	uc($t1);
	#$c1 = substr($t1,0,1);
	#if($c1 =~ ">")
	#{
	 #   @ti = split("##",$t1);
	    @ti1 = split("",$t1);	    
	   # $len = length ($ti[1]);
	    $len1 = $#ti1;
	    for($i1=1; $i1 <= 21; $i1++){$comp[$i1]=0;}
	    foreach(@ti1){
		$c2 = $_;
		$in1 = index($aa,$c2);
		$comp[$in1]++;
	    }
	    for($i1=1; $i1 <= 21; $i1++){
		$perc = ($comp[$i1]*100)/$len1;
		if($i1 <= 20)
		{
		    printf(FP2 "%5.3f,",$perc);
		}
		else
		{
		    printf(FP2 "%5.3f ",$perc);
		}
	    }
	    print FP2 "\n";
	#}

    }
    close FP1;
    close FP2;
}
if(($opt_i ne '') && ($opt_o eq ''))
{
    print "# Amino Acid Composition of proteins \n";
    print "# A , C , D , E , F , G , H , I , K , L , M , N , P , Q , R , S , T , V , W , Y\n";
    open(FP1,"$file1");
    while($t1=<FP1>){
	chomp($t1);
	uc($t1);
	$c1 = substr($t1,0,1);
	if($c1 =~ ">")
	{
	    @ti = split("##",$t1);
	    @ti1 = split("",$ti[1]);	    
	    $len = length ($ti[1]);
	    $len1 = $#ti1;
	    for($i1=1; $i1 <= 20; $i1++){$comp[$i1]=0;}
	    foreach(@ti1){
		$c2 = $_;
		$in1 = index($aa,$c2);
		$comp[$in1]++;
	    }
	    for($i1=1; $i1 <= 20; $i1++){
		$perc = ($comp[$i1]*100)/$len;
		if($i1 <= 19)
		{
		    printf( "%5.3f,",$perc);
		}
		else
		{
		    printf ("%5.3f ",$perc);
		}
	    }
	    print "\n";
	}
	
    }
    close FP1;
    exit();
}
#Developed by G. P. S. Raghava on 10 Jan 2009
