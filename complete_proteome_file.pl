if($ARGV[0] eq ''){print '$ARGV[0]=unique_id eg. P38903
$ARGV[1]=svm locate output file eg. >P38903/757@116##	0.071867712
$ARGV[2]=uniprot id fasta file  eg. >P38903
				    ACFATYRTTASDDAVHTYTA
$ARGV[3]=output file'."\n";}


open(FH,$ARGV[0]); 
open(FH1,$ARGV[1]);
open(FH2,$ARGV[2]);
open(FA,">$ARGV[3]");
@unique_id=<FH>;
@locate=<FH1>;
@fasta=<FH2>;
close FH,FH1,FH2;
foreach $id(@unique_id){
	chomp($id);

	foreach $fasta(@fasta){chomp($fasta);
				if($fasta=~/>$id\#\#/){
				print FA"\n<protein $id>\n";
				print FA"\t<Sequence>\n";
					@split=split('##',$fasta);
					$len=length($split[1]);
					for($i=0;$i<=$len;){
						$sub=substr($split[1],$i,80);
						print FA"\t".$sub."\n";
						$i+=80;
						}
				print FA"\t</Sequence>\n";
				}
			  }
	$st=0;
	foreach $line(@locate){#print FA"\t\t<position-Score>";
		chomp($line);
		if($line=~/>$id\//)
			{
			@ext=split('@',$line);
			@split2=split("\#\#",$ext[1]);
                        $split2[0]=~s/\s//g;
                        $split2[1]=~s/\s//g;
			#>A6ZKI7/163@69##	-1.2962324
			if($split2[0] >= $st){
			#print FA"\t\t<position>Serine ".$split2[0]."</position>\t<Score>".$split2[1]."</Score>\n";
			if($split2[1]>=1.3){$predt='Yes'}else{$predt='.'}
			print FA"\t\t<position>Serine ".$split2[0]."</position>\t<Score>".$split2[1]."</Score><pred>$predt</pred>\n";
 $st=$split2[0];			
			$st11=$st;
}
		   #        $st=$split2[0];			
			#$st11=$st;
			#print FA$st."\n";
			if($split2[0] < $st11){
			if($split2[1]>=1.3){$predt='Yes'}else{$predt='.'}
			#print FA"\t\t<position>Threonine ".$split2[0]."</position>\t<Score>".$split2[1]."</Score>\n";
			print FA"\t\t<position>Threonine ".$split2[0]."</position>\t<Score>".$split2[1]."</Score><pred>$predt</pred>\n";
			$st11=200000;	
                     		
			}
		}

	}
		
		#>P38903/757@19##
		#>P38903/757@20##
		#>P38903/757@21##
		#print FA"\t\t</position-Score>\n";
		
		
		print FA"</protein $id>\n";
}
