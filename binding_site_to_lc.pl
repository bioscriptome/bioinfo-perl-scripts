#!/usr/bin/perl
##program for extracting sequence from given position##
#usage 
@seq=@posit="";$i=0;
open(FP,$ARGV[0]);
open(FR,$ARGV[1]);
#@posit=<FP>;
@seq=<FR>;
while($len=<FP>)
#print "$len\n";
#for($i=0;$i<$len;$i++)
{
    chomp($len);
   # print "$len xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\n";
    @res=split("##",$len);
    @fres=split(" ",$res[1]);
    for($i=0;$i<@seq;$i++)
    {
	if($seq[$i] =~ /$res[0]/)
	{
	    @res1=split("##",$seq[$i]);
	    #print"$seq[$i]\n";
	    @res2=split(//, $res1[1]);
	    #print "@res2";
	    for($j=0;$j<@fres;$j++)
	    {
		#@acc=" ";
		$ab=$fres[$j];
		#print "$ab " ;
		$result=lc($res2[$ab-1]);
		#splice(@res2, $ab,1, "$result");
		$res2[$ab-1]="$result";
		@acc=@res2;
	    }

	    
	}
	#print "@res2\n";
    }	
    #print "@acc\n";  
    print "@res[0]::@res2";
}
print "";
