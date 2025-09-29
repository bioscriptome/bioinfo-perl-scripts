open(FH,$ARGV[0]);#file having unique_id
open(FH1,$ARGV[1]);#file from which line is to b extracted
open(FA,">".$ARGV[2]);#ouputfile
@id=<FH>;
@file=<FH1>;
close FH,FH1;
$count=0;
foreach $seq(@file){
chomp($seq);
#print $seq."\n";
#$count++;print $count."\n";
     foreach $id(@id){

chomp($id);
      if($seq=~/$id/){print FA $seq."\n";}
    }

}
