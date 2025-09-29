open(FH,$ARGV[0]);
@array=<FH>;
close FH;
$i=0;
foreach $line(@array){
chomp($line);
#AT G=0.5 & C=20 average=0.158204554412913
$line=~s/AT //g;
($split1[$i],$split2[$i])=split("average=",$line);
$hash{$split1[$i]}=$split2[$i];

$i++;
}@rev_sort=reverse sort(@split2);
#print @rev_sort;
foreach $val(@rev_sort){
while (($key, $value) = each(%hash)){
	if ($value eq $val){
	
	@param=split(" & ",$key);
	foreach $par(@param){print $par."\t";}
	printf("%1.3f\n",$value);

            }
	}
 }
