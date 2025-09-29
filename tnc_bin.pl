#!/usr/bin/perl 
#require "/media/data/gpsr_1.0/includes/base_env";
use Getopt::Std;
getopts('i:o:x:');
$file1=$opt_i;
$file2=$opt_o;
$mode=$opt_x;
#open(SCORE,">$file2".'.score');
if(($opt_i eq ''))
	{
    print "USAGE: pro2tpc -i <input file> -o Output file\n";
    print "-i\tSequence in S-FASTA format\n";
    print "-o\tOutput file\n"; 
    exit();
	}
	if ($mode =~ /y|yes/i) { $aa="#ACGT";$num=4; 
		@TNC=('ATT','ATC','ATA','CTT','CTC','CTA','CTG','TTA','TTG','GTT','GTC','GTA','GTG','TTT','TTC','ATG','TGT','TGC','GCT','GCC','GCA','GCG','GGT','GGC','GGA','GGG',' CCT','CCC','CCA','CCG','ACT','ACC','ACA','ACG','TCT','TCC','TCA','TCG','AGT','AGC','TAT','TAC','TGG','CAA','CAG' ,'AAT','AAC','CAT','CAC','GAA','GAG','GAT','GAC','AAA','AAG','CGT','CGC', 'CGA','CGG','AGA','AGG','TAA','TAG','TGA');
		print "@TNC\n";
	     }
	else{ $aa="#ACGT";$num=4;   }
if (($opt_i ne '')&&($opt_o ne ''))
   {
    open(FP1,"$file1");
    open(TNC,">$file2");
#    open(TNC,">$file2.TN_BIN");
    while($t1=<FP1>){
	    chomp($t1);
	    uc($t1);
	    if($t1 =~ " ")
	    {
		@ti = split(" ",$t1);
		$ti[1]=uc($ti[1]);
		#print SCORE $ti[0]."\n";
		print TNC $ti[0]." ";
		#print $ti[1]."\n";
		@ti1 = split("",$ti[1]);	    
		$le = length ($ti[1]);
		$len=$le-2;
		for($i1=1; $i1 <= $num; $i1++){
		    for($i2=1; $i2 <= $num; $i2++){
			for($i3=1; $i3 <= $num; $i3++)
			{
			    $comp[$i1][$i2] [$i3]=0;
			}
		    }
		 }
 $counttnc=1;
		for($j1 = 0; $j1 < $#ti1-1; $j1++){
		    $c1 = $ti1[$j1];
		    $in1 = index($aa,$c1);
		    $c2 = $ti1[$j1+1];
		    $in2 = index($aa,$c2);
		    $c3 = $ti1[$j1+2];
		    $in3 = index($aa,$c3);
		    $comp[$in1][$in2] [$in3]++;
			$tnc=$c1.$c2.$c3;
			@val=();
			undef @val;
			    foreach $get(@TNC)
			     { $get=~s/\s//g;
				if ($tnc =~ /$get/) { push (@val,1); } else {push (@val,0); }
			     }
			   ##undef $counttnc;
			   foreach $val(@val){
                                print TNC $counttnc++;print TNC ":";
				print TNC $val." ";
			     }
				$tnc='';
		}
		print TNC "\n";
	}
		$count=0;
		for($i1=1; $i1 <= $num; $i1++)
		{
		    for($i2=1; $i2 <= $num; $i2++)
		    {
			for($i3=1;$i3<=$num; $i3++)
			{
			    $perc=($comp[$i1][$i2][$i3])*100/$len;
			    $count++;
			    if($count <= 64)
			    {
				printf(FP2"%5.1f,",$perc);
			    }
			    else
			    {
				printf(FP2"%5.1f",$perc);
			    }
			    $comp[$i1][$i2][$i3]=0;
			}
		    }
		}
	print FP2 "\n";
    }
    
}
    close FP1;
    close FP2;
exit();    


