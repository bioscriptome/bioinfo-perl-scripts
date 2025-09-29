open(FH,$ARGV[0]);#file having multiple sequence no header no id only seq
open(FH1,$ARGV[1]);#file having id_pos in sfasta format  

if($ARGV[0]eq ''){print 'open(FH,$ARGV[0]);#file having multiple sequence no header no id only seq
open(FH1,$ARGV[1]);#file having id_pos in sfasta forma
$window=$ARGV[2];window size
';}

if($ARGV[0] ne ''){
    @id_pos=<FH1>;close FH1;
$window=$ARGV[2];
$add=($window-1)/2;
#$com=0; 
system "rm $ARGV[1].mot $ARGV[1].DIS";
$count=0;
system "rm $ARGV[1].mot";
open(MOT,">$ARGV[1].mot");
open(DIS,">$ARGV[1].DIS");


while($seq1=<FH>){
    $com=0;
#######    print MOT $idf."\n";
     chomp($seq1);
        ($id,$seq)=split("##",$seq1);
    $id=~s/>//g;
####################    print MOT ">".$id."\n";
    @array_pos=();
    chomp($seq);$seq=uc($seq);
    $id=~s/>//g;#print "seq ".$id."__";

    open(TEMP,">temp");
    print TEMP $seq;
#    system "java -jar ~/progs/VSL2/VSL2/VSL2.jar -s:temp -i:/home/nishant/Projects/phospho/musite/binary_neg_seprate/ss2files/pos/$id.ss2>temp_out";
    system "java -jar ~/progs/VSL2/VSL2/VSL2.jar -s:temp >temp_out";

    open(TEMP_OUT,"temp_out");
    @VSL1=<TEMP_OUT>;
    close TEMP_OUT;
    system"rm temp temp_out";

    foreach $seq11(@VSL1){
	if($seq11=~/^(\d+)\t[A-Z]\t([0-9.]+)\t/){#print $1."\t".$2."\t".$3."\n";#######
	    $array_pos[$com++]=$seq11;}
    }
    $end=scalar(@array_pos) ;
    print scalar(@array_pos)."\n";


    
    
    
    
    
    foreach $id_p(@id_pos){
	chomp($id_p); 
	$id_p=~s/>//g;
	if($id_p=~/$id/){
#	    print $id_p."__\n";

#	    print $id_p."\t".$id."\t";
	    ($idf,$poss)=split("##",$id_p);
	    @vpos=split("\t",$poss);
	    
	    
	    
	    
	    foreach $pp (@vpos){
		print MOT ">".$id."@".$pp."##";  ######################################
		@amot=();
		$count++;
		print $pp."\n"; 
		if($pp!=0 && $pp!=''){
		    $plus=$pp+$add-1; 
		    if($plus>$end){$plus=$end;}
		    $subt=$pp-$add-1;
		if($subt<0){$subt=0;}
		    #	print MOT  $subt."\t".$plus."\t";
#		    print $subt."\t".$plus."\n";
		    
			   @amot=@array_pos[$subt..$plus];
		    #print @amot; print "\n";
		    $len=scalar(@amot);
		    if($subt==0 && $len<$window && ($amot[0]!='')){
			$addx=$window-$len;
			$x='X' x $addx;
			$dis='0,' x $addx;
			print MOT "$x";
#			print DIS $dis;                             
} 
		    print DIS  ">".$id."@".$pp."##";
 if($subt==0 && $len<$window){
		    print DIS $dis;
		}
		    $da=0;
		    foreach $mo(@amot){
			if($mo=~/^(\d+)\t([A-Z])\t([0-9.]+)\t([D.])/){
			    print $1."\t".$2."\t".$3."\t".$4."\n";    
			    print MOT $2;
			    print DIS $3.",";		
			    $DIS_array[$da++]=$3;
			}
			$dis_str=join(",",@DIS_array);

			
		    }
		if($plus==$end){
		    $addx=$window-$len+1;
		    $x='X' x $addx;
		    $dis='0,' x $addx;
		    print MOT "$x";
		    print DIS $dis;
		    
		}
		    print MOT "\n";
		print DIS "\n";
		}
		
		
		 print  "\n";
	    }
    }# print MOT "\n";
	
    }
	
	
	

	
	
	

	
	
	
	


}
close MOT;

print $count;
}
