#!/usr/bin/perl
use Getopt::Std;
getopts('i:m:o:');
$in=$opt_i;
$mtx=$opt_m;
$out=$opt_o;
if($in eq ''){print "Program to convert sfasta sequence file into 544 physicochemical into 3class\nUsage: perl physico_classwise.pl -i <peptide.sfasta> -m <tsl_class_matrix.sfasta> -o <output_file>\n";}
else{
	$aa="ACDEFGHIKLMNPQRSTVWYX";
	open(PEP,$in);
	@pep=<PEP>;
	close PEP;
	open(MTX,$mtx);
	@mtx=<MTX>;
	close MTX;
	open(OUT,">$out");
        foreach $pep(@pep){
	       chomp($pep);
	       $pep=uc($pep);
               @split=split("##",$pep);
               @res=split("",$split[1]);
               print $i++;print " :";
               foreach $res(@res){
               print "$res";
               $index=index($aa,$res);
               $pos=$index;
               		foreach $mtx(@mtx){
               			chomp($mtx);
	               		@split_mtx=split("##",$mtx);
        	       		@mtx_res=split("\t",$split_mtx[1]);
                                print OUT "$mtx_res[$pos],";                
               		}
               			
               }
               print OUT "\n";
               print "\n";        
        }
}
