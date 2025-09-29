#!usr/bin/perl 
require "/home/nishant/gpsr_1.0/includes/base_env";

#$window=$ARGV[1];	#window size
#@win=qw(9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39 41 43 45);
@win=qw(15);
foreach $win(@win){
$rng= (($win -1)/2);#print $rng;exit;
$add= 'X' x $rng;
chomp $add;
$min= 'z' x $rng;
chomp $min;		#print $min;exit;

open(FH3, ">>validposmotifpssm_$win");
open(FH4, ">>validnegmotifpssm_$win");



open(FH,"$ARGV[0]");#fastafile with interaction in +,- form after sequence

while($hed=<FH>)
		{


		 $nhed=$hed;chomp $nhed;
		 chomp $hed; 
		 $hed =~ s/>//;
		 $head=$hed ;
		 $seq1=<FH>;chomp $seq1; #print "$seq1\n";
		 $seq12= $add.$seq1.$add;
		 $pat=$seq1;chomp $pat;
		 $patt= $min.$pat.$min;
		 $len= length ($seq1);  
		 @seq2= split ("", $seq12);
		 @patt= split ("", $patt);
open(SQTEMP, ">inputseq");	
print SQTEMP "$nhed\n$seq1\n";
close SQTEMP;

system "perl /home/nishant/gpsr_1.0/bin/seq2pssm_imp -i inputseq -d /home/nishant/blast-2.2.24/db/swissprot -o $head.spssm";
system "perl /home/nishant/gpsr_1.0/bin/pssm_n2 -i $head.spssm -o $head.pssm";

#system "perl /home/rahman/PROJECTS/gpsr/gpsr_1.0/bin/pssm_comp -i $head.pssm -o positive.comp";


	open(FH1, "$head.pssm");$pssm1='';
	while($pssm=<FH1>)
		{ 
			$pssm =~ s/\n/#\%/g;
			$pssm1.=$pssm;
		}
		close FH1;
			$pssm1=~s/[A-Za-z]\,//g;
			#@xpssm= split('#',$pssm1);		
			#@addxx=@xpssm;
		$X= " 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0#%";
		$Y= "#% 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0";
for($i=0;$i<$rng;$i++){$pssm1=$X.$pssm1.$Y;} $nadds=$pssm1;
		$nadds=~ s/#\%#\%/#\%/g;#print $nadds;
		

		#$nadd= $X."#%".$X."#%".$X."#%".$pssm1.$X."#%".$X."#%".$X;
		@xpssm= split('#',$nadds);	#print "@xpssm\n";	#$xxx= join('', @xpssm);$xxx=~ s/\%/\,/g;print $xxx;
			
		 #print FH3 $head."\n";
		 #print FH4 $head."\n";
		 
   open(FHMTX, "$head.mtx");@mtxseq=<FHMTX>;close FHMTX;
 
			  	
				chomp $mtxseq[1];
				$nmtxseq=$add.$mtxseq[1].$add; 	#print "$mtxhed##$nmtxseq\n";		   
			
		 for ($n=$rng;$n<($len+$rng);$n++)  {			#print "($n - $rng)##($n + $rng)\n";
					   if($patt[$n]=~ /[st]/ ){
							 	@pmotif= @seq2[($n - $rng)..($n + $rng)];
								$pmot= join ('',@pmotif);
								@motpssm= @xpssm[($n - $rng)..($n + $rng)];
								$pmotifpssm= join ('',@motpssm);
	 					#if($nmtxseq=~ /$pmot/) {
								$pmotifpssm=~ s/\%/\,/g;$pmotifpssm=~ s/^\,|\ //g;	
								print FH3 "$pmot\t$pmotifpssm\n";}

							#		}
	
					   elsif($patt[$n]=~ /[ST]/){
							   	  @nmotif= @seq2[($n - $rng)..($n + $rng)];
								$nmot=join('',@nmotif);
								@motpssm= @xpssm[($n - $rng)..($n + $rng)];	 									
								$nmotifpssm= join('',@motpssm);		    		
						#if($nmtxseq =~ /$nmot/) {  
								$nmotifpssm =~ s/\%/\,/g;$nmotifpssm=~ s/^\,|\ //g;
								print FH4 "$nmot\t$nmotifpssm\n";}
							#	 	}
					   


					   }

                			
system "rm $head.spssm *.pssm"; 
			}

system "rm inputseq";
}
close FH;
close FH3;
close FH4;
exit;
