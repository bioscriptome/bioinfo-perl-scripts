open(FH,$ARGV[0]);
open(FH1,$ARGV[1]);
open(FA,">".$ARGV[2]);

@gene_unid=<FH1>;
while($seq=<FH>){
chomp($seq);
@split=split("##",$seq);
foreach $id(@gene_unid){
  chomp($id);
      @split_id=split("\t",$id);#print $split_id[1]."hi"."\n"
      if($split[0]=~/$split_id[1]/g){print FA $id."\t".$split[1]."\n";next;}
     

}
}
