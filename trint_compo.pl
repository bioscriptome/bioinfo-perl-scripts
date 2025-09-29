#!/usr/bin/perl
# to generate trinucleotide composition

$file1=$ARGV[0];
$file2=$ARGV[1];
system "rm $file2.tnc $file2";
open(MAK,"$file1");
    open(JAK,">$file2");
    open(JAK1,">$file2.tnc");
while($line=<MAK>)
{
    chomp($line);
    $seq="ATGC";
    @nt=split(//,$seq);
    @ab=split(/\t/,$line);
    $length=length($ab[1]);
$ab[1]=uc($ab[1]);
print $length;
						    for($a=0;$a<$length-1;$a++)
						    {
							$sub=substr($ab[1],$a,3);
							$aa[$j]=$sub;
							$j++;
						    }
    $n=0;

    print JAK"$ab[0] ";
    for($c=0;$c<4;$c++)
			    {
				$b=$nt[$c];
				for($m=0;$m<4;$m++)
				{$l=$nt[$m];
				    
						    for($d=0;$d<4;$d++)
						    {
							$k=$nt[$d];
							$join=$b.$l.$k;
							$n++;
							print JAK"$n:";
							$count=0;
		
										for($h=0;$h<@aa;$h++)
									    {
#print "\n___$join"."__$aa[$h]\n\n";
												if($join eq $aa[$h])
														{
														    $count++;		       
														}
									    }
#print "\n$count\n";
							$tricomp=$count*10/($length-2);
							printf JAK"%4.3f ",$tricomp;
							printf JAK1 "%4.3f,",$tricomp;	
						    }
				}
	

}	print JAK"\n";
	print JAK1"\n";
	@aa="";
	$j=0;
    
}
