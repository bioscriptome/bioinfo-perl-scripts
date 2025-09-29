if($ARGV[0] eq ''){print '$ARGV[0]);#"phosphorylation_id_site.txt" YAL022C	27
						# YAL022C	33
						# YAL022C	39
						# YAL022C	45

open(FH,$ARGV[1]);#"phosphorylation_unique_id.tx
';
}
else{
open(FH1,$ARGV[0]);#"phosphorylation_id_site.txt" YAL022C	27
						# YAL022C	33
						# YAL022C	39
						# YAL022C	45
open(FH,$ARGV[1]);#"phosphorylation_unique_id.txt"
open(FA,">".$ARGV[2]);
@array2=<FH1>;$m=0;
while($seq1=<FH>){
chomp($seq1);$seq="";#print $seq1;
#print FA ">".$seq1."##";
print FA '>'.$seq1."##";
    foreach $seq2(@array2){      chomp $seq2;
                @array3=split("\t",$seq2);
#print $array3[0];
                 chomp($id1);
                if($array3[0]=~/$seq1/){$seq=$array3[2];$m++;$site=$array3[1];$site=~s/[A-Z]//g;
print FA $site."\t";}else {}
}
#print FA "\n".uc($seq)."\t";
print FA "\n";}
#print $m;
$a="how";
$b="are";
$c="how";
#if($a eq $c){print "yes";}

}
