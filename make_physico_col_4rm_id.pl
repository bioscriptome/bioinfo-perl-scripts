open(ID,$ARGV[0]);
$out=$ARGV[1];
open(FA,$out);
if($ARGV[0] eq ''){print '$id=$ARGV[0];file having physicochemical-544 properties list that is to be clubed to form single matrix file
$out=$ARGV[1];out pur file name
';}
@id=<ID>;close ID;
$paste="paste -d ' ' ~/Matrix/physico/aa_residue.txt ";
foreach $id(@id){chomp($id);
		 $id=~s/\s//g;
		 $paste.="~/Matrix/physico/physicochemical_544_no_aa_header/$id ";
}
print $paste;
system "$paste >$out";
close FA;
open(FH,$out);
open(TEMP,">$ARGV[2]");
@out=<FH>;
foreach $tab (@out){
    chomp($tab);
    $tab=~s/\s+/\t/g;
    print TEMP $tab."\n";
    


}
