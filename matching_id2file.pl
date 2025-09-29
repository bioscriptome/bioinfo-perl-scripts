#usage perl program file_having_less_entries file_having_complete_entries
open(FH,$ARGV[0]);
open(FH1,$ARGV[1]);
@file2=<FH1>;close FH1;
open(FA,">".$ARGV[2]);
while($file1=<FH>){
chomp($file1);
     ($ipi_f1,$uniprot1)=split("\t",$file1);
      foreach $file2(@file2){
                
      ($ipi_f2,$pos)=split("##",$file2);

       if($ipi_f2=~/$ipi_f1/g){print  FA $uniprot1.'##'.$pos;}
      }

}
