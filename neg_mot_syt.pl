# usage perl neg_mot_binding.pl inputfile_having_neg_mot  outputfile
open(FH,$ARGV[0]);
open(FA,">".$ARGV[1]);
@array=<FH>;$line=0;
foreach $mots(@array){
    chomp($mots);$line++;
    $line1=$line;
    if($mots=~/>/){
	print FA $mots."\n";
	until($array[$line1++]=~/>/){
	    $length=length($array[$line1]);
	    $residue=$length/2;
	    @mot=split("",$array[$line1]);
	    if($mot[$residue-1] eq 'Y'||$mot[$residue-1] eq 'S'||$mot[$residue-1] eq 'T'){print FA  $array[$line1];}else{}
	}
    }
}
