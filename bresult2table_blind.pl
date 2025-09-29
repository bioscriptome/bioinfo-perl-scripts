open(FH,$ARGV[0]);
open(FH1,$ARGV[1]);
#@array1=<FH>;
#@array2=<FH1>;
#close FH1;close FH2;
#if($ARGV[0] eq ''){print "ARGV[0] : Positive DB Result\nARGV[1] : Negative DB Result File\n";}
#else{
#if(scalar(@array1) eq scalar(@array2)){
#$size=scalar(@array1);
#for($i=0;$i<$size;$i++){
#chomp($array1[$i]);
#chomp($array2[$i]);
#@split1=split("\t",$array1[$i]);
#@split2=split("\t",$array2[$i]);

system " ~/blast-2.2.24/bin/blastall -p blastp -d $db/AVP_543 -i $file -F F -f 9 -b 1 -e 1000 -m 8 |cut -f1,2,11|sort -u >$fold/out_pos";
system " ~/blast-2.2.24/bin/blastall -p blastp -d $db/AVP_543 -i $file -F F -f 9 -b 1 -e 1000 -m 8 |cut -f1,2,11|sort -u >$fold/out_neg";
open(POS,"$fold/out_pos");
open(NEG,"$fold/out_neg");
undef @pos;undef @neg;@pos=<POS>;@neg=<NEG>;close POS;close NEG;
#open(TAG,"$fold/tags");
#undef @tags;@tags=<TAG>;
#foreach $tags(@tags){
#	chomp($tags);undef @get;undef $un;undef @get;$u=0;
#	foreach $un(@pos){chomp($un);if($un=~/^$tags\t.+\t.+/){	$get[$u++]=$un."\n";}}
#	$size=0;$size=scalar(@get);
#	if($size eq 0){print $tags."\tNA\t";print "@get\n";}
#	else{
	#	undef $add;
		foreach $line(@get){
			chomp($line);
			undef @cut;
			@cut=split("\t",$line);
			$add+=sprintf("%0.20f", $cut[2]);
		}
		print $tags."\t";
		printf ("%0.20f\n",$add);
	}
#}

sub def(){@var=@_;foreach $var(@var){undef $var;$var="";}}                






if(($split2[1] eq 'NA' && $split1[1] >0)||($split1[1] <$split2[1] && $split1[1] ne 'NA' )){print "$split1[0]\tTP\t$array1[$i]\t$array2[$i]\n";}
else{print "$split1[0]\tTN\t$array1[$i]\t$array2[$i]\n";}
#}
             
#}     
#}

