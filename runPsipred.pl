#!/usr/bin/perl

$file=$ARGV[0];  ## SFASTA sequence file

open (SFASTA,"$file");
while ($sfasta = <SFASTA>)
{
chomp $sfasta;
$count=1;
                $sfasta =~ />(.+?) \#\#(.+)/;
                my $head=$1; $seq=$2; $seq =uc($seq);
		print "Processing $head .. SeqNo=$count ..\n";

                    open(SQ_TEMP,">temp_seq") or die "$!";   # creating single sequence file ie seq_temp
                    print SQ_TEMP ">$head\n$seq\n";
                    close SQ_TEMP;


system "/home/rahman/softwares/PSIPRED/runpsipred temp_seq";
system "mv psitmp.mtx $head.mtx";
#print "MOVE:mv temp_seq.mtx $head.mtx\n";
system "mv temp_seq.ss $head.ss";
system "mv temp_seq.horiz $head.horiz";
system "rm temp_seq.* psitmp.*";
$count++;
}
close SFASTA;
system "rm temp_seq";
