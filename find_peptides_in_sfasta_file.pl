#!/usr/bin/perl
##program for extracting sequence from given position##
#usage 

if($ARGV[0] eq ''){print '
---$ARGV[0];#>A1L188##MSANGAVWGRVRSRLRAFPERLAACGAEAAAYGRCVQASTAPGGRLSKDFCAREFEALRSCFAAAAKKTLEGGC
---$ARGV[1];#Q9Y6I3##SRLRAFPE	EAAAYGRCVQA
';}
if($ARGV[0]ne ''){@seq=@posit="";$i=0;
open(PEP,$ARGV[1]);#Q9Y6I3##SRLRAFPE   EAAAYGRCVQA 
open(PRO,$ARGV[0]);#>A1L188##MSANGAVWGRVRSRLRAFPERLAACGAEAAAYGRCVQASTAPGGRLSKDFCAREFEALRSCFAAAAKKTLEGGC
@seq=<PRO>;
close PRO;
open(OUT,">".$ARGV[2]);
while($peptide=<PEP>)
{
    chomp($peptide);
    undef @split_pep;
    @split_pep=split("##",$peptide);
    undef @peptides;
    @peptides=split("\t",$split_pep[1]);
    for($i=0;$i<@seq;$i++)
    {  $split_pep[0]=~s/>//g;
	if($seq[$i] =~/$split_pep[0]/)
	{
	    @pro=split("##",$seq[$i]);
            $protein=uc($pro[1]);
	    #@res2=split(//, $res1[1]);
            $c=0;
            $pep_count=scalar(@peptides);
	    for($j=0;$j<@peptides;$j++)
	    {
		$ab=$fres[$j]-1;
                if($protein=~/$peptides[$j]/){print "!Found\n";
                     $c++;
                     }
                else{print "Peptide \"$peptides[$j]\" not found in \"$split_pep[0]\"\n ";}
#		$result=lc($res2[$ab]);
#		$res2[$ab]=$result;
#		@acc=@res2;
             
	    }
#print "\n";
	    
	}
    }	
if($c eq $pep_count){#print "$split_pep[0] Protein is correctly annotated !!!!!!\n";
}
  else{print "\nSomething is wrong with $split_pep[0] protein : only $c  of $pep_count Peptides are mapped!!!!!\n";}

#    print OUT "$res[0]##";foreach (@res2){print OUT $_;}
}
}
