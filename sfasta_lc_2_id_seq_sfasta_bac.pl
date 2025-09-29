if($ARGV[0] eq ''){print "ARGV[0]);#file having lowercase sfasta sequence\nARGV[1]);#file that vl have sfasta id_pos.sfasta\n";}


  open(FH,$ARGV[0]);#file having lowercase sfasta sequence                                                                                                 
  open(FA,">".$ARGV[1]);#file that vl have sfasta id_pos.sfasta                                                                                            
    open(FA1,">$ARGV[1].seq.sfasta");
while($line=<FH>){
    chomp($line);
    if($line=~/[shty]/){
	print FA1 $line."\n";

($id,$seq)= split("##",$line);
chomp($id);
print FA $id."##";@array=();@array1=();

@array=multi_index($seq,"s");
@array1=multi_index($seq,"t");
@array2=multi_index($seq,"h");
@array3=multi_index($seq,"y");



if(@array){foreach $poss(@array){print FA $poss."\t";
}}
if(@array1){foreach $poss1(@array1){print FA $poss1."\t";
}}
if(@array2){foreach $poss2(@array2){print FA $poss2."\t";
}}

if(@array3){foreach $poss3(@array3){print FA $poss3."\t";
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
