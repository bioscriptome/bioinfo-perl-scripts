#!/usr/bin/perl
## program to do simple blast from already created database and single line query sequences
## Usage: program_name input_seqsFile database_name threshold outputFile

    $inputFile=$ARGV[0];	### Input Sequence file for blast (multi-fasta file)
    $database=$ARGV[1];
    $thres   =$ARGV[2];
    $result  =$ARGV[3];


# $tag=$ARGV[1]; if want tag then use it otherwise use header

open (FF,"$inputFile");
@file1=<FF>;
close FF;
$file2=join"",@file1;
@entry=split">",$file2;

  open (RESULT,">>$result");
  print RESULT "QUERY\tHIT\tE-value\n";

for ($x=1;$x<@entry;$x++)
{
$entry[$x]=">"."$entry[$x]";
  
  $head=$seq="";

if ($entry[$x] =~ /(>.+?)\n(.+)/s)
 {
  $head=$1;$seq=$2;
  $seq =~ s/[\s\n]//g;
 }
  open (TEMP,">temp_blastInput.txt");
 open (TEMPout,">>temp_out1.txt");
  print TEMP "$head\n$seq\n";
  close TEMP;

	system "blastall -p blastp -e $thres -d $database -i temp_blastInput.txt -o temp_blast.out";
	open(MAD,"temp_blast.out");
	while($lin=<MAD>){
	    chomp($lin);
print TEMPout $lin."\n";
	 #   if(($lin=~ /significant/) && ($lin=~ /alignments:/))
             if($lin =~ /Sequences producing significant alignments:/)
                          {
		$lin=<MAD>;
#		$lin=<MAD>;
##		$lin=<MAD>; ## remove this line if First hit is required otherwise will consider the second hit
		
		$y++;
                #print "Y:$y\n";
		chomp($lin);

		@ff=split(/\s+/,$lin);
$lin=<MAD>;
		chomp($lin);

		@ff1=split(/\s+/,$lin);
print $lin."\n";
	    		  }
	    		}
	close MAD;
	if($y==0)
        { 
	    $ff[0]="No Hits"; 
	    $ff[2]="Zero";
	   
	}

    print RESULT "$head\t $ff[0]\t $ff[2]\n";
    print RESULT "$head\t $ff1[0]\t $ff1[2]\n";
#    system "rm temp_blastInput.txt temp_blast.out";
	    
# }
#}	

    } ## closing 'for' reading every test sequence
    
    close RESULT;
