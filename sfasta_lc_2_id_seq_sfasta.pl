if($ARGV[0] eq ''){print "ARGV[0]);#file having lowercase sfasta sequence\nARGV[1]);#file that vl have sfasta id_pos.sfasta\n";}
#require "/usr1/webserver/cgibin/pseapred2/PPredYeast/progs/base_env";


  open(FH,$ARGV[0]);#file having lowercase sfasta sequence                                                                                                 
#print "$ARGV[0] \t $ARGV[1]";
  open(FA,">$ARGV[1]");#file that vl have sfasta id_pos.sfasta                                                                                            
    open(FA1,">$ARGV[1].seq.sfasta");
while($line=<FH>){
    chomp($line);
    if($line=~/[st]/){
	print FA1 $line."\n";

($id,$seq)= split("##",$line);
chomp($id);
print FA $id."##";@array=();@array1=();

@array=multi_index($seq,"s");
@array1=multi_index($seq,"t");
if(@array){foreach $poss(@array){print FA $poss."\t";
}}
if(@array1){foreach $poss1(@array1){print FA $poss1."\t";
}}
print FA "\n";
}

}
sub multi_index{
@position=();
($seq_in,$mot)=@_;
$pos1=0;
$pos=index($seq_in,$mot,$pos1);
$p=0;
	while ($pos != -1) {
	#    print "Found $mot at $pos\n";
	$position[$p++]=$pos+1;
	$offset = $pos + 1;
    	$pos = index($seq_in,$mot,$offset);
  	}
return @position;
}
