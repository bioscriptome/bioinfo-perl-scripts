#!/usr/bin/perl

## Require program extractPssmPat.pl and make_pat.pl; will call them by itself

use Getopt::Std;
getopts('i:w:m:p:a:b:');

$file_seq=$opt_i;  ## multi-fasta sequence file (2-LINE FASTA FILE)
$window=$opt_w;
$file_motif=$opt_m; ## Positive motif file genrated from sequence by using ligand contact data 		WITH HEADER
$pdbid_list=$opt_p; ## List of PDBIds used in the sequences eg. 1acc_A\n2jgt_C etc 			NO '>'
$patPos=$opt_a;     ## Positive patterns	positive output column file
$patNeg=$opt_b;     ## Negative patterns	negative output column file

system "perl /home/rahman/PROJECTS/gpsr/gpsr_1.0/bin/fasta2sfasta -i $file_seq -o seq.final";

open (SFASTA,"seq.final");
#open (SFASTA,"$ARGV[0]");
while ($sfasta = <SFASTA>)
{
		chomp $sfasta;
                $sfasta =~ />(.+?) \#\#(\w+)/;
                my $head=$1; $seq=$2;

                    open(SQ_TEMP,">seq_temp") or die "$!";   # creating single sequence file ie seq_temp
                    print SQ_TEMP ">$head\n$seq\n";
                    close SQ_TEMP;

#system "perl /home/rahman/PROJECTS/gpsr/gpsr_1.0/bin/seq2pssm_imp -i seq_temp -d /home/rahman/softwares/blast-2.2.16/data/db/swissprot -o $head.spssm";
system "perl /home/rahman/PROJECTS/gpsr/gpsr_1.0/bin/pssm_n2 -i $head.spssm -o $head.pssm";

#system "perl /home/rahman/PROJECTS/gpsr/gpsr_1.0/bin/pssm_comp -i $head.pssm -o positive.comp";

system "perl /home/rahman/PROJECTS/gpsr/gpsr_1.0/bin/pssm2pat -i $head.pssm -w $window -o $head.pat";  ## pssm2pat create one header line
#system "rm $head.spssm $head.pssm";
}
close SFASTA;

system "rm seq.final seq_temp";
system "perl /home/rahman/PROJECTS/SVMProgs/pssm/extractPssmPat.pl -m $file_motif -s $file_seq -w $window -p $pdbid_list -a $patPos -b $patNeg";
