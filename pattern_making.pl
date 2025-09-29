use Pattern;
open(FH,$ARGV[0]);#file having sequence
$pattern=$ARGV[1];
$out=$ARGV[2];
open(FA,'>'.$out);
@file=<FH>;
close FH;
foreach $seq(@file){
chomp($seq);
$pat='';
@PAT=();
$i=0;
    if($pattern eq '5'){
	@base=split("",$seq);	
	  foreach $mono (@base){
	  $mono=~s/\s//g;
	  $pat=Pattern::nucbin($mono);
	  $PAT[$i++]=$pat;
	}
	 $pat=join(", ",@PAT);
		print FA $pat."\n";
	}
	
	
	
	if($pattern eq '1'){
        $seq_c=$seq;
        $seq_c=~s/U/T/g;
	$pat=Pattern::nc($seq,length($seq));
        $pat=~s/\s//g;
        @PAT=split(",",$pat);
        
	printf FA ("%4.2f,%4.2f,%4.2f,%4.2f",$PAT[0],$PAT[1],$PAT[2],$PAT[3]);
	}
	
	if($pattern eq '2'){$i=0;
	   
	  $pat=Pattern::dinuc($seq);
	 
	
	
	 
		print FA  $pat."\n";
	}
	if($pattern eq '3'){
			system "perl /media/data/progs/sipred/compo_trint.pl mot_fasta $out";
			#open(TNC,'>tnc_temp');
			#print COL (Pattern::dinuc($mot))."\n";close COL;
			#system "perl /media/data/gpsr_1.0/bin/col2svm -i col -o svm -s $efficacy";close SVM;
	}
	}
