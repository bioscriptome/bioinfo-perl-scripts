#!/usr/bin/perl
use Getopt::Std;
getopts('i:o:m:');

$sfasta=$opt_i;
$matrix=$opt_m;
$out=$opt_o;
if($sfasta eq ''||$matrix eq '' ||$out eq ''){print 'Program will create col file from the sfasta file  using blosum matrix
usage: program -i sfastafile -m matrixfile -o outputfile  
';}
else{
@aa=qw(A R N D C Q E G H I L K M F P S T W Y V X);
$pepFile=$ARGV[1];
open(OUT,">$out");
$null='0.00, 'x 21;
open (MOTIF,"$sfasta");
while ($seq=<MOTIF>)
{
    chomp $seq;@peptide=();
if (($seq =~/#/) && ($seq =~/>/)){
 
    @split1=split("##",$seq);
    $line=$split1[1];
    @peptide=split("",$line);
    foreach $res(@peptide) 
    {   
 	$count=0; $val=0;
	 open (MATRIX,"$matrix");
	 while ($line1=<MATRIX>)
	 {      chomp $line1;
     		if (($line1 !=~/#/) && ($line1 !=~/>/))                                                                  
		  { @mat=();
                   if ($line1 =~ /$res/) { $count++; @mat=split"\t",$line1; for ($x=1;$x<@mat;$x++) { print OUT "$mat[$x], ";} } 
	    
    		 }
     	 }
	 close MATRIX;
	 if ($count == 0) {print OUT "$null";}
     }
     print OUT "\n";
     }
else{print "ERROR: input file is not in sfasta format\n";exit;}
     
     
}
 close MOTIF;
close OUT;
 }
