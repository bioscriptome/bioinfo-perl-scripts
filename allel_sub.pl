if($ARGV[0] eq ''){print "ENTER the efficacy sequence file eg. 0.34 actagaatgagtagcatat\n
ENTER the matrix path a1	0.2,0.2,0,0.3........\n
";}
else{
#open(FH,$ARGV[0]);@eff_seq=<FH>;
open(FH,$ARGV[0]);@eff_seq=<FH>;
open(FM,$ARGV[1]);@matrix=<FM>;
close FM,FH;
undef %matrix;
foreach $matrix(@matrix){
	chomp($matrix);
	@split=split("\t",$matrix);	
	$matrix{$split[0]}=$split[1];
		
}

foreach $eff_sequence(@eff_seq){
	chomp($eff_sequence);
	@split1=split(" ",$eff_sequence);	
	$eff=$split1[0];#$num_nt
	$seq=$split1[1];

	@split_seq=split("",$seq);
        $num=1;$int=0;print $eff." ";
        foreach $num_nt(@split_seq){
       	 	$pos=$num++;
	       	 chomp($num_nt);$nu_nt=$num_nt.$pos;
	       	 @mat_value=split(",",$matrix{$nu_nt});
	       	 foreach $increment(@mat_value){
	       	         $int++;
	       		 print "$int:$increment ";
	        	$cont=$int;
	       		 }
        }
  #      foreach $num_nt(@split_seq){        
  #      	       		 undef $bin,@bin;
#	         if($num_nt eq 'a'){$bin='1,0,0,0';}
 #      	         if($num_nt eq 'c'){$bin='0,1,0,0';}
  #     	         if($num_nt eq 'g'){$bin='0,0,1,0';}
   #    	         if($num_nt eq 't'){$bin='0,0,0,1';}
    #   	         @bin=split(",",$bin);	        
     #  	         foreach $BIN(@bin){$cont++;print "$cont:$BIN "; }
      # 	         }
print "\n";
}
}
