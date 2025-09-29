#usage program.pl unique_id complete_data_file output_file
open(FH,$ARGV[0]);
open(FH1,$ARGV[1]);
open(FA,">".$ARGV[2]);
@line=<FH1>;
while($id=<FH>){
chomp($id);
 foreach $line(@line)  {
#if ($line=~/$id\s+UniProtKB\s+Modified\s+residue\s+(\d+)\s+\d+\s+\.\s+\.\s+.\s+Note=((Phosphoserine|Phosphotyrosine|Phosphothreonine))\s+/){print FA $id."\t".$1."\t".$2."\n";}
if ($line=~/$id\s+UniProtKB\s+Modified\s+residue\s+(\d+)\s+\d+\s+\.\s+\.\s+.\s+Note=((Phosphoserine|Phosphothreonine))\s+/){print FA $id."\t".$1."\t".$2."\n";}

 if ($line=~/$id\s+UniProtKB\s+Modified\s+residue\s+(\d+)\s+\d+\s+\.\s+\.\s+.\s+Note=((Phosphoserine|Phosphothreonine);Status=By similarity)\s+/){print FA $id."\t".$1."\t".$2."\n";}

}
}
close FH,FH1,FA;
