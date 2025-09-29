#!/usr/bin/perl
open(SEQS,$ARGV[0]);@seqs=<SEQS>;close SEQS;
$mmm=0;@sub_seq1=();@sub_seq2=();
foreach $seqid(@seqs){
$mmm++;
	open(TEMP,">TEMP");
	print TEMP $seqid;
	close TEMP;
	system "rm out1";
	system("~/Desktop/align0.exe TEMP  $ARGV[1]   >out1$mmm");system "dos2unix out1$mmm";
	@store=`~/Desktop/align0.exe TEMP  $ARGV[1]   `;
        print "@store";
	open(FO,"out1$mmm");
	@array=();@array=<FO>;close FO,TEMP;
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
	@u=split "\n",$sew;
	$A=index($l2,"A");$C=index($l2,"C");$G=index($l2,"G");$T=index($l2,"T");
	sub max{ my $max = pop(@_);  foreach (@_){ $max = $_ if $_ > $max; }  $max; } 
	sub min{ my $min = pop(@_);  foreach (@_) { $min = $_ if $_ < $min;}$min; }
	@large=($A,$C,$G,$T);
	$mi=min(@large);
	$length=length($l2);
	@seq2=split("",$l2);
	@seq1=split("",$l1);@seq3=split("",$l3);@seq4=split("",$l4);@seq5=split("",$l5);
	@align1=@seq1[$mi..$length];@align2=@seq2[$mi..$length];@align3=@seq3[$mi..$length];	@align4=@seq4[$mi..$length];@align5=@seq5[$mi..$length];
####	print @align3;print "\n";
	$align4=join("",@align4);
	$align2=join("",@align2);
	$align3=join("",@align3);
	$sub_align="";
	if($align4=~/(\-+)([ATGCU][ATGCU-]*[ATGCU])/){$start1=length($1);$sub_seq2=$2;$end=length($sub_seq2);}
	if($align2=~/^.{$start1}(.{$end})/){$sub_seq1=$1;}
	$sub_seq1[$mmm-1]=$sub_seq1;
        $large_seq1[$mmm-1]=length($sub_seq1);
	$sub_seq2[$mmm-1]=$sub_seq2;
	}
$max=max(@large_seq1);
###print $max."\n";
open(FASTA,">test");
for($co=0;$co<=scalar(@sub_seq2);$co++){
print  FASTA ">".$pid++."\n".$sub_seq2[$co]."\n";
print  FASTA ">".$pid++."\n".$sub_seq1[$co]."\n";
}
