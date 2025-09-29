#!/usr/bin/perl
open(SEQS,$ARGV[0]);@seqs=<SEQS>;close SEQS;
$mmm=0;@sub_seq1=();@sub_seq2=();
$a=0;
foreach $seqid(@seqs){
$mmm++;
	open(TEMP,">TEMP");
	print TEMP $seqid;
	close TEMP;
	@array=`/home/nishant/progs/align0.exe TEMP  $ARGV[1]   `;
	print $ccc++;print "\n";
	close TEMP;
        $start_alpha=split("",$ARGV[1]);
	$se=join("#",@array);$l4=~s/\s{7}//g;$se=~s/\s/\*/g;@array1=();@array1=split("#",$se);
	@align=();$sew='';$sew1='';$sew2='';$sew3='';$sew4='';$l=0;
	foreach $line(@array1){$l++;
	    if($line=~/^TEMP\*+(.+)\*/){
				 $sew.=$array1[$l-2];
		                 $sew1.=$1;
		                 $array1[$l]=~s/\*{7}//;chop($array1[$l]);
		                 $sew2.=$array1[$l];
                  	         $array1[$l+1]=~s/\*{7}//;chop($array1[$l+1]);
		                 $sew3.=$array1[$l+1];
		                 $sew4.=$array1[$l+2];
	    }
	   }
	$l1=$sew;$l2=$sew1;$l3=$sew2;$l4=$sew3;$l5=$sew4;
        $index_1=index($l4,$start_alpha);
	$l4=~tr/uU/TT/;
	@u=split "\n",$sew;
	$A=index($l4,"A");$C=index($l4,"C");$G=index($l4,"G");$T=index($l4,"T");
	$Ar=rindex($l4,"A");$Cr=rindex($l4,"C");$Gr=rindex($l4,"G");$Tr=rindex($l4,"T");
	sub max{ my $max = pop(@_);  foreach (@_){ $max = $_ if $_ > $max; }  $max; } 
	sub min{ my $min = pop(@_);  foreach (@_) { $min = $_ if $_ < $min;}$min; }
	@large=($A,$C,$G,$T);@last=($Ar,$Cr,$Gr,$Tr);
	$mi=min(@large);$cutfrom=$mi;
        $maxr=max(@last);$cutupto=$maxr;
	$length=length($l2);
	@seq2=split("",$l2);
	@seq1=split("",$l1);@seq3=split("",$l3);@seq4=split("",$l4);@seq5=split("",$l5);
	@align1=@seq1[$mi..$maxr];@align2=@seq2[$mi..$maxr];@align3=@seq3[$mi..$maxr];	@align4=@seq4[$mi..$maxr];@align5=@seq5[$mi..$maxr];
	$final_align[2]=join("",@align4);$final_align[0]=join("",@align2);$final_align[1]=join("",@align3);$loop=$maxr-$mi;
	@splitl1=split("",$final_align[0]);@splitl2=split("",$final_align[1]);@splitl3=split("",$final_align[2]);
#	foreach(@final_align){print "$_\n";}
		for($lo=0;$lo<$loop;$lo++){
			if(($splitl1[$lo] eq '*') && ($splitl2[$lo] eq '*') && ($splitl3[$lo] eq '*')){undef($splitl1[$lo]);undef($splitl2[$lo]);undef($splitl3[$lo]);}
		}	
	    #    $joinli[0]=join("",@splitl1);
		$joinli[1]=join("",@splitl2);
	#	$joinli[2]=join("",@splitl3);
		#$joinli[3]="#";
$max=max(@large_seq1);
#print "\n";
foreach(@joinli){$control[$a++]=$_;}
}
foreach(@control){print $_."\n";}


__END__
open(FASTA,">test");
for($co=0;$co<=scalar(@sub_seq2);$co++){
print  FASTA ">".$pid++."\n".$sub_seq2[$co]."\n";
print  FASTA ">".$pid++."\n".$sub_seq1[$co]."\n";
}
