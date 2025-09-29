#!/usr/bin/perl
if($ARGV[0] eq ''){print "Usage: perl siRNA.pl folder_name\n";}
$fold=$ARGV[0];
print $fold;
$model=$ARGV[1];
$progs="/usr1/webserver/cgibin/servers/ppredyeast/virsirnapred/progs";
system "perl $progs/fasta2sfasta -i $fold/seq -o $fold/seq.sfasta -g $fold";
open(FO,"$fold/temp.out");
open(SIRNA,">$fold/siRNA");
@array=<FO>;
close FO;
foreach $line(@array){
        chomp($line);
        @split=split("##",$line);
        
        $name=$split[0];
        $seq=$split[1];
        $seq=lc($seq);
        $len=length($seq);
        $end=$len-18;

        for($i=1;$i<$end+1;$i++){
                $sirna=substr($seq,$i-1,19);
                $sirna=~tr/atgc/tacg/;
                $sirna=reverse($sirna);
                print SIRNA "$i $sirna\n"; 

        }

}
system "perl $progs/hybrid_mdttpb1440_freq.pl $fold/siRNA $fold/siRNA.pat";
if($model eq 1){system " $progs/svm_classify_1  $fold/siRNA.pat $progs/siRNA_mod_$model $fold/result_score";print "\n $progs/svm_classify1  $fold/siRNA.pat $progs/siRNA_mod_$model $fold/result_score\n";
# `cut -d ' ' -f1,2 $fold/siRNA |awk '{print $1,"\t",$2}'>$fold/tag`;
system "paste   $fold/siRNA $fold/result_score>$fold/final_file";
} 
if($model eq 2){system " $progs/svm_classify_1 $fold/siRNA.pat $progs/siRNA_mod_$model $fold/result_score";}
