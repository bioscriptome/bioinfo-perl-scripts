open(FH,$ARGV[0]);#file haing positive lowercase sfatsa
#open(FA1,">".$ARGV[1]);#file haing negative lowercase sfatsa
open(FA,">temp");
$num=$ARGV[2];
while($seq=<FH>){
chomp($seq);
($id,$seq1)=split("##",$seq);chomp($id);
print FA $id." ##";
    $seq1=uc($seq1);
$seq1=~s/S/s/g;
$seq1=~s/T/t/g;
chomp($seq1);
print FA $seq1."\n";


}
close FA;
$name=$ARGV[1];
#($name1,$dum)=split("\.",$name);
$name_final=$name."_id_pos.txt";
system "perl ~/progs/sfasta_lc_2_id_seq_sfasta.pl temp $name_final";
system "mv temp $ARGV[1]";


__END__
open(TEMP,"temp_pos");
open(TEM2,">outing");
while($line=<TEMP>){
chomp($line);
open(TEM,">WRIT");
($uid,$line1)=split("##",$line);
 @POS=split("\t",$line1);
foreach (@POS){print TEM $_."\n";}
close TEM;
print $num."\n";
system "perl ~/progs/createRandomSeq.pl WRIT $num out21";
open(TEM1,"out21");
@out1=<TEM1>;
close TEM1;

print  TEM2 $uid." ##";foreach (@out1){chomp($_);print TEM2 $_."\t";} print TEM2 "\n";
}close TEM2;
system "perl ~/progs/Binding_residue_from_uppe2lower.pl  outing temp $ARGV[1]  ";
#$idpos=$ARGV[1]."_id_pos.txt";                                                                                                                            
#system "mv temp_pos $idpos";   
