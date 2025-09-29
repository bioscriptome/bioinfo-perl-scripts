#!/usr/perl/bin
#usage perl program.pl    temp_pos2_positemotif   temp_pos2_negmotif    seqfile_sfasta    outputfile    motifsize

open(FH,$ARGV[0]);         #file having position of positive  motif eg.YBL005W-B       5       45      76      89
open(FH1,$ARGV[1]);        #file having position of negative motif  eg.YBL005W-B:      3       7       10      16      20      22      23      28
open(FH2,$ARGV[2]);        #sequence file in sfasta format eg.YBL005W-B ##MESQQLSQHSPIFHGSACASVTSKEVQTTQDPLDISASKTEECEKVSTQANSQQPT
open(FA,">".$ARGV[3]);     #Name of the output file 
$window=$ARGV[4];
$mot_size=$ARGV[5];        #Size of the motif
$size=($mot_size-1)/2;
@neg_id=<FH1>; close FH1;
@seq_file=<FH2>;

while ($posit_id=<FH>){    
    chomp($posit_id);$line=0;print ">$posit_id\n";#print the position of positive motif eg. YBL005W-B       5       45      76      89 
    @array=();
    @posit_pos=split("\t",$posit_id);
    foreach $neg_id (@neg_id){       #file having position of neg motif
	chomp($neg_id);
	@neg_pos=split("\t",$neg_id);                   
	for($i=1;$i<scalar(@posit_pos);$i++){
                                             chomp($posit_pos[0]);
                                             $posit_pos[0] =~ s/://g; chomp($neg_pos[0]);
					     if($neg_pos[0] =~ /$posit_pos[0]/){
                                                  $line++;$line1=0;
						  for($j=1;$j<scalar(@neg_pos);$j++){
						         chomp($posit_pos[$i]);
                                                         chomp($neg_pos[$j]); 
				 if(($neg_pos[$j] > ($posit_pos[$i]-$size)) && ($neg_pos[$j] < ($posit_pos[$i]+$size))){
										print "\t\t".$posit_pos[$i]."\t".$neg_pos[$j]."\n";
	              	                                                        push (@array,$neg_pos[$j]);
			                                                            }
				        		                         #$array[$line][$line1++]=$neg_pos[$j];
					                         		}
			         		print "\n";			    }
					     
					     
					 }
    }
    # exit;
    @array=sort { $a <=> $b } @array;  ## Sorted @mark numbers but repeated numbers exist
    my %seen = ();
    @array = grep { ! $seen{$_} ++ } @array;   ## making @mark uniq array
    foreach $seq(@seq_file){ 
	chomp($seq);
	if($seq=~/$posit_pos[0]/){ 
	    @seq=split(" ##",$seq);
		$seq_uc=uc($seq[1]);
	    $ADD='X' x (($window-1)/2);
	    $seq_uc=$ADD.$seq_uc.$ADD;
	    print $seq_uc."\n";
	    print FA "\n>$posit_pos[0]"; 
 	    for ($x=0;$x<@array-1;$x++) {print $array[$x]."\t";
                                        # $position=($array[$x]-$ADD;
					 $neg_mot=substr($seq_uc,$array[$x]-1,$window);
					 print "$neg_mot\n";	
					 print FA "\n$neg_mot";} print "\n";
	}
    }
}

close FH; close FH1;

__END__
    
    for($h=0;$h<scalar(@array);$h++){
	for($k=0;$k<scalar($array[$h][$h]);$k++){
	    # print $array[$h][$k]."\n";
	}
    }
