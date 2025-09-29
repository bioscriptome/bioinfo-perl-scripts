#!/usr/bin/perl
##program for extracting sequence from given position##
#usage 
@seq=@posit="";$i=0;
open(FP,$ARGV[0]);#Q9Y6I3##394 395 410 429 435 439 445 469 
open(FR,$ARGV[1]);#>A1L188##MSANGAVWGRVRSRLRAFPERLAACGAEAAAYGRCVQASTAPGGRLSKDFCAREFEALRSCFAAAAKKTLEGGC
#@posit=<FP>;
@seq=<FR>;
open(OUT,">".$ARGV[2]);
while($len=<FP>)
#print "$len\n";
#for($i=0;$i<$len;$i++)
{
    chomp($len);
  # print "$len xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\n";
    @res=split("##",$len);
    @fres=split("\t",$res[1]);$res[0]=~s/>\s+//g;
#print @fres;
$res[0]=~s/ //g;
print $res[0];
    for($i=0;$i<@seq;$i++)
    {  
	if($seq[$i] =~/$res[0]/)
	{
	    @res1=split("##",$seq[$i]);
            $res1[1]=uc($res1[1]);
	#print"$seq[$i]\n";
	    @res2=split(//, $res1[1]);
	    #print "@res2";
	    for($j=0;$j<@fres;$j++)
	    {
		#@acc=" ";
		$ab=$fres[$j]-1;
		#print "$ab " ;
		$result=lc($res2[$ab]);
		#splice(@res2, $ab,1, "$result");
		$res2[$ab]="$result";
		@acc=@res2;
	    }

	    
	}
	#print "@res2\n";
    }	
    #print "@acc\n";  
    print OUT "$res[0] ##";foreach (@res2){print OUT $_;}
}
#print "@acc\n";
