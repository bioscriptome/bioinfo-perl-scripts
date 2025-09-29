#!usr/bin/perl 
open(FH1, ">>temp");
open(FH2, ">>temp1");

$result=`grep -v 'Spec' $ARGV[0] | grep -v '*'`;
print FH1 $result;
close FH1;
open(FH3, "temp");
while($line=<FH3>){
			if($line =~ /g|c|j/){ $add=$line;chomp $add;
					      #print FH2 "$line";
					    }
					
			else{ chomp $line;print FH2 "$add\t$line\n";    
						

								 
			    }
			
		
		   }
close FH2;
close FH3;
open(FH4, ">>temp2");
	
$sorted=`sort -nrk16 temp1`;print FH4 $sorted;

system "head -3000 temp2 > outhead3000";
close FH4;
open(FH5, "outhead3000");
open(FH6, ">>FINALRESULTSVM");
print FH6 "Parameters\twin\tInstncs\tSens\tSpeci\tAccu\tDiff\tMCC\tAUC\t\tThreshold\n";
while($line=<FH5>)
		{chomp $line;
		 @line1=split("\t", $line);#print $line1[0]."\n";
		$sens=@line1[8]; $spec=@line1[9];$diff= ($spec - $sens);$diff=~ s/\-//;
		
		$auc=@line1[2]; $aaa=@line1[4]; $bbb=@line1[5];$ccc=@line1[6];$ddd=@line1[7];$sum= ($aaa + $bbb + $ccc + $ddd );

		print FH6 "$line1[0]\t$line1[1]\t$sum\t$line1[8]\t$line1[9]\t$line1[10]\t";
		printf( FH6 "%5.3f",$diff);
		print FH6 "\t$line1[11]\t$auc\t$line1[3]\n";

}close FH5;
system "sort -nrk13 FINALRESULTSVM > AUC-SORTED";
system "rm temp temp1 temp2 outhead3000";





