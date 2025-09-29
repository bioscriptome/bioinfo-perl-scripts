open(FH,$ARGV[0]);#file haing positive lowercase sfatsa
#open(FA1,">".$ARGV[1]);#file haing negative lowercase sfatsa
open(FA,">temp");
while($seq=<FH>){
chomp($seq);
($id,$seq1)=split("##",$seq);chomp($id);
print FA $id."##";
$seq1=~s/s/\@s\@/g;
$seq1=~s/t/\@t\@/g;
#$seq1=lc($seq1);
$seq1=~s/S/s/g;
$seq1=~s/T/t/g;
$seq1=~s/\@s\@/S/g;
$seq1=~s/\@t\@/T/g;
chomp($seq1);
print FA $seq1."\n";


}
close FA;
system "perl ~/progs/sfasta_lc_2_id_seq_sfasta.pl temp temp_pos";
system "perl ~/progs/Binding_residue_from_uppe2lower.pl  temp_pos temp $ARGV[1]  ";
system "rm temp";
$idpos=$ARGV[1]."_id_pos.txt";
system "mv temp_pos $idpos";
