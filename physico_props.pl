open(FH,$ARGV[0]);
open(FA,">physico_chemical_properties");
#while($seq=<FH>){#if($seq=~/^H/){print FA "\n".$seq;}#elsif($seq=~/(^D|^T)/){print FA $seq;}#}
open(FH1,$ARGV[1]);@array=<FH1>;
$value=join('',@array);
$value=~s/\n//g;
$value=~s/\s+/ /g;
print $value;
@array1=split(" ",$value);open(FAA,">".$ARGV[2]);
foreach $val(@array1){print FAA $val."\n";}
#system "paste -d '^I' $ARGV[2]"


