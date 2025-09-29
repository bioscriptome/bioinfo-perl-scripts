open(AAI,$ARGV[0]);#physicochemicalAAIndexfile;
@array=<AAI>;
close AAI;
$line=0;
$id_c=0;
$id='';
$str='';
foreach $seq(@array){
    chomp($seq);
    $line++;
    if($seq=~/^H\s+([A-Z0-9]+).+/){#print $seq."\n";
	$id=$1;
	$id[$id_c++]=$id;
    }
	print $id."\n";
    if($seq=~/^I/){#print $seq."\n";
	$pos=$line;
	$value=$array[$pos].$array[$pos+1]."\n";
    }
    $value=~s/\n//g;
    $value=~s/\s+/ /g;
#    print $value."\n";
    if($value=~/NA/){
	print $value."\n";
	@aa=('A','R','N','D','C','Q','E','G','H','I','L','K','M','F','P','S','T','W','Y','V','X');
	@array1=split(" ",$value);
	open(FAA,">".$id);#outputfile
	    $line1=0;
        $str=$str.$id.' ';
	
	foreach $val(@array1){
		#print FAA $aa[$line1++]."\t".$val."\n";with AMINO ACID NAME eg...... A	4.5
	    print FAA $val."\n";
	}
	print FAA "0";
	#print FAA "X\t0";with AMINO ACID NAME eg...... A	4.5
	close FAA;}
    
    
}
open(ID,">ID_FOR_PHYSICO_544_WITHOUT_HEADER.txt");
$str3='';
print scalar @id;
foreach $s(@id){$str3=$str3.$s.' ';print ID $s."\n";}
print "paste -d ',' $str3";
