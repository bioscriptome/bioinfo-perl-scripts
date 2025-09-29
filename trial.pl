#!/usr/bin/perl
## This is the alternate program of proram.pl for PSSM 17window motif pattern generation. Here two input file 1st input is the output file of psi_output_21_amino.pl and secnod is the 17 window sequence patern (+Ve/-Ve).
$file=$ARGV[0];
$file1=$ARGV[1];
$amino="ACDEFGHIKLMNPQRSTVWX";
@cc=split(//,$amino);
open(IN,"$file");
while($line=<IN>)
{
    chomp($line);
    $n++;
    @A=split(/\ :: /,$line);
    @seq=split(/\ /,$A[1]);
    @psi=split(/\ ; /,$A[2]);
    $aa=join"",@seq;
    #print "$aa\n";
    $len=@seq;
    open(FP,"$file1");
    while($line1=<FP>)
    {
	chomp($line1);
	$count=0;
	#print "$line1\n";
	if($aa =~ $line1)
	{
	    $count++;
	    print "$line1 :: \n";
	    $min=index($aa,$line1);
	    $max=$min+15;  
	    @var1="";
	    @var2="";
	    for($i=$min;$i<$max;$i++ )
	    {
		@var=split(" ",$psi[$i]);
		for($m=0;$m<@var;$m++)
		{  
		    $var2[$m]=(1/(1+(2.7182)**(-$var[$m])));
		    $var1[$m]=sprintf("%7.5f",$var2[$m]);
		   # print "$var1[$m] ";
		}
		print "@var1 ";
	    }
	    print "\n";
	}
    }
}


