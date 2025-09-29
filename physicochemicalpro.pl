#!/usr/bin/perl
$file=$ARGV[0];			##----sequence file can be multiple sequneces no fasta header----------##
$file_out=$ARGV[1];   		##------------------output file----------------##
open(FH,$file);
open(FP, ">$file_out");#$count=1000;
while ($seq1=<FH>){$count++;
chomp($seq1);
@seqq=split("\##", $seq1);
$seq=$seqq[1];chomp $seq;
	#print FP "$count\t";
	#print FP "$seq\t";
	%hash= stop($seq,"hydrophobicity_new.txt");  
	printf (FP "%3.2f,",$avvg);
	%hash= stop($seq,"steric.txt");
        printf (FP "%3.2f,",$avvg);
	%hash= stop($seq,"sidebulk.txt");
        printf (FP "%3.2f,",$avvg);
	%hash= stop($seq,"nethydrogen.txt");
        printf (FP "%3.2f,",$avvg);
	%hash= stop($seq,"hydrpathy.txt");
        printf (FP "%3.2f,",$avvg);
	%hash= stop($seq,"amphipathicity.txt");
        printf (FP "%3.2f,",$avvg);
	%hash1= stop($seq,"hydrophilicity.txt");
	printf (FP "%3.2f,",$avvg);
	%hash11= stop($seq,"charge.txt");
	printf (FP "%3.2f,",$sum);
	%hash12= stop($seq,"pi.txt");
	printf (FP "%3.2f,",$avvg);
	@ab=split('',uc($seq)); $n=18*(@ab-1);
		$val=0;$sum=0;
			foreach $res(@ab){   
				open (FH1,"mol_wt.txt");@mat=();
		 		while ($line1=<FH1>){
		    			chomp $line1;
		   			if ($line1 =~ /$res/) { 
						@mat=split"\t",$line1; 
						$val=$mat[1];
        	                            }
				}
				$sum +=$val;
			} 
			$net=($sum-$n);
		printf (FP "%3.2f\n",$net);

}

##-----------subroutine starts-------#######

sub stop{
    ($seq,$path)=@_;
    $seq=uc($seq);$len=length($seq);
    @seq=split("",$seq);
    open(PRO,$path);
    @prop=<PRO>;
    close PRO;
    foreach $line(@prop){
        chomp($line);
	@split=split("\t",$line);
        $property{$split[0]}=$split[1];
    }
    $sum=0;$avg=0;
    $aa = "ACDEFGHIKLMNPQRSTVWYX";
    @aa=split("",$aa);
    foreach(  @aa){$sum_p{$_}=0;}
    foreach $res(@seq){
        $val=$property{$res};
        $sum_p{$res}=$sum_p{$res}+$val;
        $sum += $val;
    }$avvg=($sum/$len);#print "$avvg\n";
    return %sum_p;
}
