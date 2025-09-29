
if($ARGV[0] eq ''){print "usage lc_inputfile.sfasta out number_of_residue2lc\n";}
		   else{
open(FH,$ARGV[0]);#file haing positive lowercase sfatsa
#open(FA1,">".$ARGV[1]);#file haing negative lowercase sfatsa
open(FA,">temp");
$num=$ARGV[2];
$lcho=$th1=$totalh=$lsoh=$lsos=$lsot=$totals=$totalt=$inverset=$inverses=$inversest=0;
while($seq=<FH>){
  chomp($seq);
  ($id,$seq1)=split("\#\#",$seq);chomp($id);
  print FA $id."##";
  $s11=$s21=$seq1;
        $lcso=($s11=~tr/s//);
        $lcto=($s11=~tr/t//);
        $ts1=($s21=~tr/Ss//);
        $tt1=($s21=~tr/Tt//);
        $lcho=($s11=~tr/h//);
        $th1=($s21=~tr/hH//);
        

$lsos+=$lcso;
$lsot+=$lcto;
$totals+=$ts1;
$totalt+=$tt1;
$totalh+=$th1;
$lsoh+=$lcho;
  $seq1=~s/s/\@s\@/g;$seq1=~s/t/\@t\@/g;$seq1=~s/h/\@h\@/g;;$seq1=~s/y/\@y\@/g;
  $seq1=~tr/S/s/;$seq1=~tr/T/t/;$seq1=~tr/H/h/;$seq1=~tr/Y/y/;
  $seq1=~s/\@s\@/S/g;$seq1=~s/\@t\@/T/g;$seq1=~s/\@h\@/H/g;$seq1=~s/\@y\@/Y/g;

  $t11=$t21=$seq1;
        $iso=($t11=~tr/s//);
        $ito=($t11=~tr/t//);
        $iho=($t11=~tr/h//);
        $iyo=($t11=~tr/y//);

$inverses+=$iso;
$inverset+=$ito;
$inverseh+=$iho;
$inversey+=$iyo;

  chomp($seq1);
  print FA $seq1."\n";

}
$orignal_st=$lsos+$lsot+$lsoh+$lsoy;
$total_st=$totals+$totalt+$totalh+$totaly;
$inversest=$inverses+$inverset+$inverseh+$inversey;

print "Origanl lc S= $lsos\n";
print "Origanl lc T= $lsot\n";
print "Origanl lc h= $lsoh\n";
print "Total lc STH= $orignal_st\n";
print "Total  S= $totals\n";
print "Total  T= $totalt\n";
print "Total  = $totalh\n";
print "Total  STH= $total_st\n";
print "Inverse lc S= $inverses\n";
print "Inverse lc T= $inverset\n";
print "Inverse lc H= $inverseh\n";
print "Inverse lc STH= $inversest\n";
close FA;
system "perl ~/progs/sfasta_lc_2_id_seq_sfasta_bac.pl temp temp_pos";
open(TEMP,"temp_pos");
open(TEM2,">outing");
while($line=<TEMP>){
chomp($line);
undef @POS;

open(TEM,">WRIT");
($uid,$line1)=split("##",$line);
 @POS=split("\t",$line1);
foreach (@POS){print TEM $_."\n";}
close TEM;

open(Test,"WRIT");
@test=<Test>;close Test;
$lent=scalar(@test);
#print $id."\t".$lent."\n";

if($lent>$num){
system "perl ~/progs/createRandomSeq.pl WRIT $num out21";
}
open(TEM1,"out21");

if($ARGV[2] eq ''){system "perl ~/progs/createRandomSeq.pl WRIT $lent out21"}
@out1=<TEM1>;
close TEM1;

print  TEM2 $uid."##";foreach (@out1){chomp($_);print TEM2 $_."\t";} print TEM2 "\n";
}close TEM2;
system "perl ~/progs/Binding_residue_from_uppe2lower.pl temp outing  $ARGV[1]  ";

system "rm WRIT  out21  ";
$idpos=$ARGV[1]."_id_pos.txt";
#system "mv temp_pos $idpos";
}
