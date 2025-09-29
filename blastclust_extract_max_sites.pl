open(FH,$ARGV[0]);
open(FH1,$ARGV[1]);
@file=<FH1>;close FH1;
#open(FA,">".$ARGV[0]);
while($clust=<FH>){
chomp($clust);
@clust=split("\s",$clust);
foreach $id(@clust){
print $id."\n";
   foreach $seq(@file){
   if($seq=~/$id/){
   @split=split("##",$seq);
   @count=split("\t",$split[1]);
   print @count,"\n";
   }
   
   }

}

}
