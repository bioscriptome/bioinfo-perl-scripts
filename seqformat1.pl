#!/usr/bin/perl

$file1=$ARGV[0];
###$file2=$ARGV[1];
chomp($file1);

open(MAN,"$file1");
while($line=<MAN>) 
{
    chomp ($line);
    $line=~ s/\s+/ /g;
    @ab=split(/ /,$line);
    ###$n1++;
    ###print "$n1 ::";
    
    #if ($line=~ /\d/) 
    #{
	chomp($line);
        @aa=split(/ /,$line);
    if(@aa >1){
       
 #print"$line\n";
	#print "$aa[3]\n";
	#print "$aa[3] $aa[0] $aa[1]\n";

#	if($aa[3] eq "X")
	{
	    print"$line\n";
	}
	
	
	##open(MAP,">>$file2");
	###print MAP "$line\n";
	###print "$line\n";
    }
#}
#close MAP;
}
