#!/usr/bin/perl
use Getopt::Std;
getopts('i:m:o:t:');
$in=$opt_i;
$matrix=$opt_m;
$out=$opt_o;
open(FO,">$out");
open(CLASS,">$out\.class");
open(MATRIX,$matrix);open(POS,$pos);open(in,$in);
@matrix=<MATRIX>;@pos=<POS>;@in=<in>;
close MATRIX;close POS;close in;
$aa = "ACDEFGHIKLMNPQRSTVWY";
foreach $in(@in){
	chomp($in);
	@split_in=split("##",$in);
	@in_aa=split("",$split_in[1]);
        $count=0;
        $size_of_mat=$#matrix;
	foreach $mat(@matrix){
	        chomp($mat);
	       	$class1=$class2=$class3=0;
	        @split_mat=split("##",$mat);
	        @aa_mat=split("\t",$split_mat[1]);
	        print "@in_aa\n";
	        $count++;
	        $i=0;$size_of_i=$#in_aa;
		foreach $in_aa(@in_aa){
		        $i++;   
			#foreach $aa_mat(@aa_mat){
			#if($in_aa eq $aa_mat)
			#}
			#print "$aa,$in_aa\n";
			$index=index($aa,$in_aa);
			print FO $aa_mat[$index];
			print $count."\t$size_of_mat\n";
			#if($size_of_mat > $count){print FO ",";}
			#else{
			#	if($size_of_i lt $i){
			#	print FO ",";}else{print FO "";}
			#}
		        print FO ",";
			if($aa_mat[$index] eq 1){$class1++;}
			elsif($aa_mat[$index] eq 2){$class2++;}
			elsif($aa_mat[$index] eq 3){$class3++;}
			
		}
		print CLASS "$class1,$class2,$class3,";
		
	}print CLASS "\n";
print FO "\n";
}
close FO,CLASS;
