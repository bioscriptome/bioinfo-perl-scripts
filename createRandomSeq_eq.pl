#!/usr/bin/perl

###              Program to select random sequences from a pool of sequences (single line format) 
###              Usage: program_name input_Sequencefile NumberOfOutputSequencesRequired outputFile

open (INPUTFILE,"$ARGV[0]"); ## input Sequence File in single line format
@seqs=<INPUTFILE>;
close INPUTFILE;
$add=$ARGV[3];
$noOfOutputSeqs=$ARGV[1];    ## input for number of output sequences required
$outputFile=$ARGV[2];        ## Output File containing random sequences
open (OUTPUT,">$outputFile");
$noOfSeqs=scalar(@seqs); ## this is range for random number generator
$start=0;                ## this is minimum number to start  
if ($noOfSeqs<$noOfOutputSeqs) 
	{ 	print "Sorry! number of sequences present in the file ($noOfSeqs)  is less than You required ($noOfOutputSeqs) in the output\n"; exit;}
@arrayRandom=();@unique_array=();
$loop=0;
until(scalar(@unique_array) eq $noOfOutputSeqs){
	for($x=0;$x<($noOfOutputSeqs+$add);$x++)
	{ print $loop++;print "\t";print scalar(@unique_array);print "\n";
		$random_number= int (rand($noOfSeqs));
		#print $random_number;
		push (@arrayRandom,$random_number);     ## creating an array of random numbers generated $$$ but there may be repeatition of numbers, so sequences
	}
	#print "@arrayRandom";
	#print scalar(@arrayRandom);					## preparing for unique random number array from our previous random number array
	my %seen =() ;
	@unique_array = grep { ! $seen{$_}++ } @arrayRandom ; ## unque random array created
	@arrayRandom=();
}

foreach $ran(@unique_array)
{ 
	print OUTPUT "$seqs[$ran]";
}
close OUTPUT;
