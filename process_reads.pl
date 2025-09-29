#!/usr/bin/perl -w
use strict;
# this file removes the adepters and filters for low quality

### START OF INPUT
open FILE_R, "<", "INPUT.fastq" or die $!; #input fastq
open FILE_W, ">", "OUTPUT.fastq" or die $!; #output fastq (after filtering) 
my $minimal_quality=20;
my $max_number_of_strikes=3; # max number of bases with quality lower than $minimal_quality
my $error_min_final_length=15; # was 15. discard the read if it's too short after trimming
my $error_max_final_length=28; # was 28. discard the read if it's too long after trimming

my $must_be_at_start_of_adaptor3=5; # 
my $must_be_at_start_of_adaptor5=6; # changing this number require code changing
my $adaptor5="GTTCAGAGTTCTACAGTCCGACGATC";
my $adaptor3="TCGTATGCCGTCTTCTGCTT"; 
my $ascii_to_quality_convertor=33;

### END OF INPUT

my $number_of_seq=0;
my $seq_after_filter=0;
my $too_long_flag=0;
my $too_short_flag=0;
my $no_adaptor3_flag=0;
my $low_quality_flag=0;

my $string;
my @array;
my $value;
my $runner;
my $sequence;
my $ascii;
my $title_seq;
my $title_ascii;
my $include_flag;
my $start_at;
my $end_at;
my $i;
my $specific_length;
my $pattern;
my $temp_number;
my $strikes;
my $cmd;
my $length_identity_adaptor3;
my $temp_string;
my $currect_adaptor3;
my $possibly_miR;
my $possibly_barcode;
my $string_INFO;
my $temp_length;
my $start_time;
my $end_time;
my $temp_start_string;
my $temp_end_string;
my $end_adaptor5;
my $end_adaptor5_1;
my $end_adaptor5_2;
my $end_adaptor5_3;
my $end_adaptor5_4;
my $end_adaptor5_5;
my $miRNA_present;

$string=<FILE_R>;
$start_time=time();
while ($string)
{
    if ($string =~ /^@/)
    {
        $miRNA_present=0;
        $include_flag=1;
        $specific_length=0;
        $number_of_seq=$number_of_seq+1;
        $temp_number=$number_of_seq/10000;
        if ($temp_number !~ /\D/)
        {
            print "sequence number=",$number_of_seq,"\n";
        }
        $title_seq=$string;
        $string=<FILE_R>;
        $sequence=$string;
        
        # first screen
        $possibly_miR='';
        $end_adaptor5=substr($adaptor5,-$must_be_at_start_of_adaptor5);
        $end_adaptor5_1=substr($adaptor5,-1);
        $end_adaptor5_2=substr($adaptor5,-2);
        $end_adaptor5_3=substr($adaptor5,-3);
        $end_adaptor5_4=substr($adaptor5,-4);
        $end_adaptor5_5=substr($adaptor5,-5);        
        $temp_start_string=substr($adaptor3,0,$must_be_at_start_of_adaptor3);
        if  ($sequence =~ /(\w+?)$temp_start_string/)
        {
            $possibly_miR=$1;
            if ($possibly_miR =~ /$end_adaptor5(\w+)/)
            {
                $start_at=index($possibly_miR,$1);
                $possibly_miR=$1;
            }
            elsif ($possibly_miR =~ /^$end_adaptor5_5(\w+)/)
            {
                $start_at=index($possibly_miR,$1);
                $possibly_miR=$1;
            }
            elsif ($possibly_miR =~ /^$end_adaptor5_4(\w+)/)
            {
                $start_at=index($possibly_miR,$1);
                $possibly_miR=$1;
            }                
            elsif ($possibly_miR =~ /^$end_adaptor5_3(\w+)/)
            {
                $start_at=index($possibly_miR,$1);
                $possibly_miR=$1;
            }
            elsif ($possibly_miR =~ /^$end_adaptor5_2(\w+)/)
            {
                $start_at=index($possibly_miR,$1);
                $possibly_miR=$1;
            }
            elsif ($possibly_miR =~ /^$end_adaptor5_1(\w+)/)
            {
                $start_at=index($possibly_miR,$1);
                $possibly_miR=$1;
            }                
            else
            {
                $start_at=0; 
            }
            $temp_length=length($possibly_miR);
            if (($temp_length<=$error_max_final_length)&&($temp_length>=$error_min_final_length))
            {
                $end_at=$temp_length-1+$start_at; 
                $miRNA_present=1;
            }
            elsif ($temp_length>$error_max_final_length)
            {
                $too_long_flag=$too_long_flag+1;
                $include_flag=0;
            }
            elsif ($temp_length<$error_min_final_length)
            {
                $too_short_flag=$too_short_flag+1;
                $include_flag=0;
            }
        }
        
        if ($miRNA_present==1)
        {
            $specific_length=$end_at-$start_at+1;
            $string=<FILE_R>;            
        }
        else
        {
            if ($include_flag==1)
            {
                $include_flag=0;
            }
            $string=<FILE_R>;
            $string=<FILE_R>;
            $string=<FILE_R>;
        }
    }
    else
    {
        last;
    }
    if ($string =~ /^\+/)
    {
        $title_ascii=$string;
        $string=<FILE_R>;
        $ascii=substr($string,$start_at,$specific_length);
        @array=split(//,$string);
        $strikes=0;
        for($runner=$start_at;$runner<=$end_at;$runner++)
        {
            $value=ord($array[$runner])-$ascii_to_quality_convertor;
            if ($value<$minimal_quality)
            {
                $strikes=$strikes+1;           
            }
        }
        if ($strikes>$max_number_of_strikes)
        {
            $low_quality_flag=$low_quality_flag+1;
            $include_flag=0;
        }
        $string=<FILE_R>;
    }
    if ($include_flag)
    {
        $seq_after_filter=$seq_after_filter+1;
        if ($title_seq =~ /(\S+)/)
        {
            $title_seq=$1."_0";
        }
        else
        {
            print "something worng\n";
        }
        if ($title_ascii =~ /(\S+)/)
        {
            $title_ascii=$1."_0";
        }
        else
        {
            print "something worng\n";
        }
        print FILE_W $title_seq,"\n";
        print FILE_W $possibly_miR,"\n";
        print FILE_W $title_ascii,"\n";
        print FILE_W $ascii,"\n";
    }
}

close(FILE_R);
close(FILE_W);

$end_time=time();
$end_time=$end_time-$start_time;


print "number of sequences before filtering: ",$number_of_seq,"\n";
print "number of sequences  after filtering: ",$seq_after_filter,"\n";
print "number of sequences filtered because they were too long: ",$too_long_flag,"\n";
print "number of sequences filtered because they were too short: ",$too_short_flag,"\n";
print "number of sequences filtered because they had low sequencing quality: ",$low_quality_flag,"\n";
print "time taken to calc (sec): ",$end_time,"\n";

# srr346423 cortex (with ATC at the begining of 3' adapter)
#number of sequences before filtering: 26563173
#number of sequences  after filtering: 19329664
#number of sequences filtered because they were too long: 394836
#number of sequences filtered because they were too short: 609994
#number of sequences filtered because they had low sequencing quality: 59666
#shaharal@yoavg1:~/mouse_sra_miRNA$ bowtie -n 1 -e 50 -a -m 1 --best --strata --phred33-quals --trim3 2 ../bowtie-0.12.5/indexes/mm9 mouse_cortex.fastq > cortex_3trim_aligned_to_genome_V.txt
# reads processed: 19329664
# reads with at least one reported alignment: 8204744 (42.45%)
# reads that failed to align: 239032 (1.24%)
# reads with alignments suppressed due to -m: 10885888 (56.32%)

# srr346417 cerebellum (with ATC at the begining of 3' adapter)
#number of sequences before filtering: 24775043
#number of sequences  after filtering: 18765057
#number of sequences filtered because they were too long: 717434
#number of sequences filtered because they were too short: 546326
#number of sequences filtered because they had low sequencing quality: 234109
#shaharal@yoavg1:~/mouse_sra_miRNA$ bowtie -n 1 -e 50 -a -m 1 --best --strata --phred33-quals --trim3 2 ../bowtie-0.12.5/indexes/mm9 mouse_cereb.fastq > cereb_3trim_aligned_to_genome_V.txt
# reads processed: 18765057
# reads with at least one reported alignment: 8337549 (44.43%)
# reads that failed to align: 248628 (1.32%)
# reads with alignments suppressed due to -m: 10178880 (54.24%)

# srr345196 hippocampus1 NOTE: due to low sequencing quality, my $minimal_quality=10; $max_number_of_strikes=5; (without ATC at the begining of 3' adapter)
#number of sequences before filtering: 9764245
#number of sequences  after filtering: 3811545
#number of sequences filtered because they were too long: 372
#number of sequences filtered because they were too short: 332577
#number of sequences filtered because they had low sequencing quality: 262170
#shaharal@yoavg1:~/mouse_sra_miRNA$ bowtie -n 1 -e 50 -a -m 1 --best --strata --phred33-quals --trim3 2 ../bowtie-0.12.5/indexes/mm9 mouse_hippo1.fastq > hippo1_3trim_aligned_to_genome_V.txt
# reads processed: 3811545
# reads with at least one reported alignment: 749690 (19.67%)
# reads that failed to align: 165622 (4.35%)
# reads with alignments suppressed due to -m: 2896233 (75.99%)

# srr345202 hippocampus2 NOTE: due to low sequencing quality, my $minimal_quality=10; $max_number_of_strikes=5; (without ATC at the begining of 3' adapter)
#number of sequences before filtering: 9607729
#number of sequences  after filtering: 3270174
#number of sequences filtered because they were too long: 918
#number of sequences filtered because they were too short: 35946
#number of sequences filtered because they had low sequencing quality: 1764790
#shaharal@yoavg1:~/mouse_sra_miRNA$ bowtie -n 1 -e 50 -a -m 1 --best --strata --phred33-quals --trim3 2 ../bowtie-0.12.5/indexes/mm9 mouse_hippo2.fastq > hippo2_3trim_aligned_to_genome_V.txt
# reads processed: 3270174
# reads with at least one reported alignment: 1533419 (46.89%)
# reads that failed to align: 55634 (1.70%)
# reads with alignments suppressed due to -m: 1681121 (51.41%)
