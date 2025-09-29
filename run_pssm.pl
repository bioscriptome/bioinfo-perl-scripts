#!/usr/bin/perl
use Getopt::Std;
getopts('p:w:o:t:');
$pos=$opt_p;
$win=$opt_w;
$out=$opt_o;
$tag=$opt_t;
if($pos eq ''){print 'Usage: perl run_pssm.pl -p <lc_fasta_file> -w <windows plz seprate 2windows with comas like 11,13,15> -o <outputfile suffix> -t <tag for svm file>'."\n";}
else{
chomp($win);
require "/home/nishant/gpsr_1.0/includes/base_env";
@win=split(",",$win);
foreach $win(@win){
$rng= (($win -1)/2);#print $rng;exit;
$add= 'X' x $rng;
chomp $add;
$min= 'z' x $rng;
system "mkdir data_processed";
system "mkdir data_processed/$win";
$pat="data_processed/$win";
chomp $min;		#print $min;exit;
open(FH3, ">$pat/$out\_$win");
open(MOT, ">$pat/$out\_$win.mot");
open(PSSM, ">$pat/$out\_$win.pssm");
open(FH4, ">$pat/Neg\_$out\_$win");
open(FH,"$pos");#fastafile with interaction in +,- form after sequence
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
                system "perl $gpsr_home/bin/seq2pssm_imp -i inputseq -d $gpsr_blastdb/swissprot -o $head.spssm";
                system "perl $gpsr_home/bin/pssm_n2 -i $head.spssm -o $head.pssm";
        	open(FH1, "$head.pssm");$pssm1='';
        	while($pssm=<FH1>)
        		{ 
        			$pssm =~ s/\n/#\%/g;
        			$pssm1.=$pssm;
        		}
		close FH1;
		$pssm1=~s/[A-Za-z]\,//g;
		$X= " 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0#%";
		$Y= "#% 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0";
                for($i=0;$i<$rng;$i++){$pssm1=$X.$pssm1.$Y;} $nadds=$pssm1;
		$nadds=~ s/#\%#\%/#\%/g;#print $nadds;
		@xpssm= split('#',$nadds);	#print "@xpssm\n";	#$xxx= join('', @xpssm);$xxx=~ s/\%/\,/g;print $xxx;
                 open(FHMTX, "$head.mtx");@mtxseq=<FHMTX>;close FHMTX;
  		 chomp $mtxseq[1];
		 $nmtxseq=$add.$mtxseq[1].$add; 	#print "$mtxhed##$nmtxseq\n";		   
		 for ($n=$rng;$n<($len+$rng);$n++)  {			#print "($n - $rng)##($n + $rng)\n";
					   if($patt[$n]=~ /[st]/ ){
							 	@pmotif= @seq2[($n - $rng)..($n + $rng)];
								$pmot= join ('',@pmotif);
								@motpssm= @xpssm[($n - $rng)..($n + $rng)];
								$pmotifpssm= join ('',@motpssm);
								$pmotifpssm=~ s/\%/\,/g;$pmotifpssm=~ s/^\,|\ //g;
								print MOT "$pmot\n";									
								print PSSM "$pmotifpssm\n";																	
								print FH3 "$pmot\t$pmotifpssm\n";}
					   elsif($patt[$n]=~ /[ST]/){
							   	  @nmotif= @seq2[($n - $rng)..($n + $rng)];
								$nmot=join('',@nmotif);
								@motpssm= @xpssm[($n - $rng)..($n + $rng)];	 									$nmotifpssm= join('',@motpssm);		    		
								$nmotifpssm =~ s/\%/\,/g;$nmotifpssm=~ s/^\,|\ //g;
								print FH4 "$nmot\t$nmotifpssm\n";}
		}
   #             system "rm $head.spssm *.pssm"; 
	}
      #   system "rm inputseq";
close FH;
close FH3;
close PSSM;
close MOT;
#system "cut -f2  $pat/$out\_$win >$pat/$out\_$win.col";
system "perl ~/gpsr_1.0/bin/col2svm -i $pat/$out\_$win.pssm -o $pat/$out\_$win\_pssm.svm -s $tag";
#system "rm $out\_$win >$pat/$out\_$win\.col";
close FH4;

      
}
exit;      
}
