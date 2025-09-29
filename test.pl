#!/usr/bin/perl
$line=$ARGV[0];
$name=$ARGV[1];
chomp($file);
chomp($name);

$amino="XGAVLIMPFYWSTCNQRKHED";
@cc=split(//,$amino);

    $line=~ s/[\s]//g;
    @prot=split(//,$line);
    $len=@prot;
open(NAS,">>$name");
print NAS"0";
close NAS;
open(MAJ,"correct_format");

while($li=<MAJ>){
	    chomp($li);
	    $val="";
	    @value=split(/ +/,$li);

    for($p=0;$p<@prot;$p++){

	for($a=0;$a<@cc;$a++){
	    
	#print "----->$prot[$p]\t  $cc[$a]\n";
	    if($prot[$p] eq "$cc[$a]"){
	
		$val +=$value[$a];
	
	    }
	}

	$val1=$val/$len;
	$val1=sprintf "%5.3f",$val1;
    }
	$number++;	    
	    open(MAL,">>$name");
	    print MAL" $number:$val1";
	    close MAL;
	  
	}
    close MAJ;
    open(MAL1,">>$name");
	print MAL1"\n";
close MAL1;
