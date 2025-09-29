#!/usr/bin/env perl
open(MTX,"allele_18pos.mtx");
@mtx=<MTX>;
close MTX;
foreach $matrix(@mtx){chomp($matrix);@mtx_split=split("\t",$matrix);$hash{$mtx_split[0]}=$mtx_split[1];}
$match=10;$mismatch=-10;$gop=-10;$gep=-10;
open F0, $ARGV[0];
while ( <F0>){$al0.=$_;}
close F0;
open F1, $ARGV[1];
while ( <F1>){$al1.=$_;}
close F1;
@name_list0=($al0=~/>(.*)[^>]*/g);
@seq_list0 =($al0=~/>.*([^>]*)/g);
@name_list1=($al1=~/>(.*)[^>]*/g);
@seq_list1 =($al1=~/>.*([^>]*)/g);
foreach $seq (@seq_list0){$seq=~s/[\s\d]//g;}
foreach $seq (@seq_list1){$seq=~s/[\s\d]//g;}
for ($i=0; $i<=$#name_list0; $i++){$res0[$i]=[$seq_list0[$i]=~/([a-zA-Z-]{1})/g];}
for ($i=0; $i<=$#name_list1; $i++){$res1[$i]=[$seq_list1[$i]=~/([a-zA-Z-]{1})/g];}
$len0=$#{$res0[0]}+1;
$len1=$#{$res1[0]}+1;
$zero=0;
for ($i=0; $i<=$len0; $i++){$smat[$i][0]=$zero;$tb[$i][0 ]=2;}
for ($j=0; $j<=$len1; $j++){$smat[0][$j]=$zero;$tb[0 ][$j]=2;}
for ($i=1; $i<=$len0; $i++)
	{
	for ($j=1; $j<=$len1; $j++)
		{
		if ($res0[0][$i-1] eq $res1[0][$j-1]){$s=$match;}
		else {$s=$mismatch;}
		$sub=$smat[$i-1][$j-1]+$s;
		$del=$smat[$i  ][$j-1]+$gep;
		$ins=$smat[$i-1][$j  ]+$gep;
		if($sub>$del && $sub>$ins && $sub> $zero){$smat[$i][$j]=$sub;$tb[$i][$j]=0;}
		elsif($del>$ins && $del>$zero              ){$smat[$i][$j]=$del;$tb[$i][$j]=-1;}
		elsif($ins>$zero                           ){$smat[$i][$j]=$ins;$tb[$i][$j]=1;}
		else {$smat[$i][$j]=$zero;$tb[$i][$j]=2;}
		if ($smat[$i][$j]> $best_score)
		  {
		     $best_score=$smat[$i][$j];
		     $best_i=$i;
		     $best_j=$j;
		   }
	        }
	}

$i=$best_i;
$j=$best_j;
$aln_len=0;
while (!($i==0 && $j==0) && $tb[$i][$j]!=2)
	{
	if ($tb[$i][$j]==0)
		{
		$aln0[$aln_len]=$res0[0][--$i];
		$aln1[$aln_len]=$res1[0][--$j];
		}
	elsif ($tb[$i][$j]==-1)
		{
		$aln0[$aln_len]='-';
		$aln1[$aln_len]=$res1[0][--$j];
		}
	elsif ($tb[$i][$j]==1)
		{
		$aln0[$aln_len]=$res0[0][--$i];
		$aln1[$aln_len]='-';
		}
	$aln_len++;
	
	}
$i++;
$j++;
$add1=$add2='';
print "$name_list0[0]:$i-$best_i\t";
for ($i=$aln_len-1; $i>=0; $i--){
$add1.=$aln0[$i];
print $aln0[$i];}
print "\n";
print "$name_list1[0]:$j-$best_j\t";
for ($j=$aln_len-1; $j>=0; $j--){
	$add2.=$aln1[$j];
	print $aln1[$j];
	}
print "\n";
@seq1=split("",lc($add1));
@seq2=split("",lc($add2));
for($in=0;$in<scalar(@seq1);$in++){
	if($seq1[$in] eq $seq2[$in]){}
	else{
		$snp=$in+1;
		print "ALLELE :$seq1[$in]=>$seq2[$in] AT $snp"."th nt\n";
		$start=$snp-19;if($start<0){$start=0;}
		$end=($snp+18);
		print $start."\t".$end."\nWILD\n";
		print @seq1[$start..$end];print " SENSE\n";
		@a1=@seq1[$start..$end];
		$revseq1=join("",@a1);
		$revseq1=~tr/uU/tt/;
		$allele1=  reverse($revseq1);
		$allele1 =~ tr/ACGTacgt/TGCAtgca/;
		print reverse($allele1)." COMP\n";
		print "$allele1 REVCOMP\nMUTATED\n";		
		@a2=@seq2[$start..$end];
		$revseq2=join("",@a2);
		$revseq2=~tr/uU/tt/;
		print @seq2[$start..$end];print " SENSE\n";
		$allele2=  reverse($revseq2);
		$allele2 =~ tr/ACGTacgt/TGCAtgca/;
		print reverse($allele2)." COMP\n";
		print "$allele2 REVCOMP\n\n";
		open(AL1,">ALLELE1.seq");
		open(TEM,">TEMP");
		open(AL2,">ALLELE2.seq");
		for($cut=0;$cut<19;$cut++){
		$cut1=substr($allele1,$cut,19);
		$cut1=lc($cut1);
		print AL1 "0 $cut1\n";
		$cut2=substr($allele2,$cut,19);
		$cut2=lc($cut2);
		print AL2 "0 $cut2\n";		
		print TEM "$cut1\n";	
		}

		system "perl ~/progs/sipred_progs/mk/binnt.pl ALLELE1.seq ALLELE1.pat";
		system "perl ~/progs/sipred_progs/mk/binnt.pl ALLELE2.seq ALLELE2.pat";		
		system "~/progs/sipred_progs/mk/svm_classify ALLELE1.pat model_dieter2431_19 ALLELE1.score";
		system "~/progs/sipred_progs/mk/svm_classify ALLELE2.pat model_dieter2431_19 ALLELE2.score";
		system "paste   ALLELE2.score TEMP |cut -f1,2>mutate.eff_seq";
# A G T C
		if(($seq2[$in] eq 't') && ($seq1[$in] eq 'a')){$col=0;}
		if(($seq2[$in] eq 't') && ($seq1[$in] eq 'g')){$col=1;}
		if(($seq2[$in] eq 't') && ($seq1[$in] eq 't')){$col=2;}
		if(($seq2[$in] eq 't') && ($seq1[$in] eq 'c')){$col=3;}

		if(($seq2[$in] eq 'c') && ($seq1[$in] eq 'a')){$col=0;}
		if(($seq2[$in] eq 'c') && ($seq1[$in] eq 'g')){$col=1;}
		if(($seq2[$in] eq 'c') && ($seq1[$in] eq 't')){$col=2;}
		if(($seq2[$in] eq 'c') && ($seq1[$in] eq 'c')){$col=3;}

		if(($seq2[$in] eq 'a') && ($seq1[$in] eq 'a')){$col=0;}
		if(($seq2[$in] eq 'a') && ($seq1[$in] eq 'g')){$col=1;}
		if(($seq2[$in] eq 'a') && ($seq1[$in] eq 't')){$col=2;}
		if(($seq2[$in] eq 'a') && ($seq1[$in] eq 'c')){$col=3;}

		if(($seq2[$in] eq 'g') && ($seq1[$in] eq 'a')){$col=0;}
		if(($seq2[$in] eq 'g') && ($seq1[$in] eq 'g')){$col=1;}
		if(($seq2[$in] eq 'g') && ($seq1[$in] eq 't')){$col=2;}
		if(($seq2[$in] eq 'g') && ($seq1[$in] eq 'c')){$col=3;}


		$nt=$seq2[$in];
		$nt=~tr/tcga/agct/;
		open(AL1SCORE,"mutate.eff_seq");
		@AL1SCORE=<AL1SCORE>;		close AL1SCORE;
		$check=0;
		foreach $score(@AL1SCORE){
		chomp($score);$check++;
		$ntpos=$nt.$check;
		print $ntpos."\t";
		($AL1_eff,$AL1_seq)=split("\t",$score);
		$orignal = sprintf "%.3f", $AL1_eff;
		@split_mtx=split(",",$hash{$ntpos});
		print $orignal." $split_mtx[$col]\t";
		$add_eff=$orignal+$split_mtx[$col];
		printf("%.3f\t%s\t",$add_eff,$AL1_seq);
		$AL1_seq=~ tr/ACGTacgt/TGCAtgca/;
		print reverse($AL1_seq)."\n";
		}
	}
}
