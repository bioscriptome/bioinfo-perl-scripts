open(FH,$ARGV[0]);
@array=<FH>;
close FHl
foreach $id(@array){
chomp($id);
$url="http://phytamp.pfba-lab-tun.org/getentry.php?id=$id";
system "lynx -dump -width 500 $url >>out";


}
