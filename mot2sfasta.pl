open(FH,$ARGV[0]);
open(FA,">$ARGV[1]");
if($ARGV[0] eq ''){print "\$ARGV[0]Enter motif file\n\$ARGV[1] the output file\n";}
@array=<FH>;
close FH;
$i=1;$pos='pos';
foreach $mot(@array){chomp($mot);
if($mot=~/>/){}	else{	     
$pos=$pos.$i++;
		     print FA  ">".$pos."##".$mot."\n";
		     $pos="pos";
}
		 }
