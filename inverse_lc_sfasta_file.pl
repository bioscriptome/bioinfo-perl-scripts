#usage lc_inputfile.sfasta out number_of_residue2lc
open(FH,$ARGV[0]);#file haing positive lowercase sfatsa
#open(FA1,">".$ARGV[1]);#file haing negative lowercase sfatsa
open(FA,">temp");
$num=$ARGV[2];
while($seq=<FH>){
chomp($seq);
($id,$seq1)=split("##",$seq);chomp($id);
print FA $id." ##";
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
open(TEMP,"temp_pos");
open(TEM2,">outing");
while($line=<TEMP>){
chomp($line);
open(TEM,">WRIT");
($uid,$line1)=split("##",$line);
 @POS=split("\t",$line1);
foreach (@POS){print TEM $_."\n";}
close TEM;

open(Test,"WRIT");
@test=<Test>;close Test;
$lent=scalar(@test);
print $id."\t".$lent."\n";

if($lent>$num){
system "perl ~/progs/createRandomSeq.pl WRIT $num out21";
}
open(TEM1,"out21");

if($lent<=$num){system "perl ~/progs/createRandomSeq.pl WRIT $lent out21"}
@out1=<TEM1>;
close TEM1;

print  TEM2 $uid." ##";foreach (@out1){chomp($_);print TEM2 $_."\t";} print TEM2 "\n";
}close TEM2;
system "perl ~/progs/Binding_residue_from_uppe2lower.pl  outing temp $ARGV[1]  ";
system "rm WRIT out* temp temp_pos";
#$idpos=$ARGV[1]."_id_pos.txt";
#system "mv temp_pos $idpos";
