#open(FH,$ARGV[0]);
open(FA,">physico_chemical_properties");
open(FH1,$ARGV[0]);#file having values eg     4.35    4.38    4.75    3.95
		   #			      4.17    4.36    4.52    3.95
@array=<FH1>;
$value=join('',@array);
$value=~s/\n//g;
$value=~s/\s+/ /g;
print $value;
@aa=('A','R','N','D','C','Q','E','G','H','I','L','K','M','F','P','S','T','W','Y','V');
@array1=split(" ",$value);
open(FAA,">".$ARGV[1]);#outputfile
$line=0;
foreach $val(@array1){
print FAA $aa[$line++]."\t".$val."\n";
}


