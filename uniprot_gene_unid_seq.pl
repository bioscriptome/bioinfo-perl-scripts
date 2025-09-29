#!/usr/perl/bin
#usage perl program.pl gene_unid.txt gene_unid_seq.txt outputfile.txt
open(FH,$ARGV[0]);
open(FH1,$ARGV[1]);
open(FA,">$ARGV[2]");
@gene_unid=<FH>;
@gene_unid_seq=<FH1>;close FH,FH1;
foreach $line(@gene_unid){
chomp($line);
@split=split("\t",$line);
   foreach $seq (@gene_unid_seq)
   {chomp($seq);
   @seqarray=split("\t",$seq);
    if($split[0] eq $seqarray[0]){ print  "\n".$seqarray[0]."\t".$split[0];$split[1]=~s/\s//g;$seqarray[2]=~s/\s//g;chomp($split[1]);chomp($seqarray[2]);
         if($seqarray[2]=~/$split[1]/g){print FA $seq."\n";}else {print "  not found\n";}
    }
  }


}
close FA;
