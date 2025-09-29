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
	
$sorted=`sort -nrk13 temp1`;print FH4 $sorted;
#system "head -150 temp2 > outhead150";
system "head -3000 temp2 > outhead300";
close FH4;
open(FH5, "outhead300");
open(FH6, ">>FINALRESULTSVM");print FH6 "PARAM\t\t\tTHRES\tTP\tTN\tFP\tFN\tSENS\tSPEC\tACCU\tMCC\tDIFF\tINSTANCES\n";
while($line=<FH5>)
		{chomp $line;
		 @line1=split("\t", $line);#print $line1[0]."\n";
		$spec=@line1[6]; $sens=@line1[7];$diff= ($spec - $sens);$diff=~ s/\-//;
		$aaa=@line1[2]; $bbb=@line1[3];$ccc=@line1[4];$ddd=@line1[5];$sum= ($aaa + $bbb + $ccc + $ddd );
		print FH6 "$line\t";printf (FH6 "%5.3f" ,$diff);print FH6 "\t$sum\n";

}close FH5;
system "rm temp temp1 temp2 outhead300";
