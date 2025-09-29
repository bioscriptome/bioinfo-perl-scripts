#!/usr/bin/perl -w
use strict;
use Math::CDF qw(:all);
my $prob = pnorm(1.96);

# input
my $file1_name="main_output.txt"; # the output file of Analyze_mutation.pl 
my $p_mismatch=0.001; # the sequencing error probability
my $max_position_to_check=19; # ignore last two bases
my $first_N_bases=2; # If the mismatch is in the first N bases of the miRNA AND the mismatch is in isomir with expression level which is order of magnitude below the 'main' isomir, the mismatch is ignored (as we observed 5' adenylation and uridylation in low-abundance isomirs)    
my $BH_or_bonferroni="BH"; # multiple testing correction: a choice between "BH" (Benjamini-Hochberg correction) or "bonferroni" (Bonferroni correction) 
my $P_value=0.05; # the P-value required after multiple testing correction (this is the FDR if Benjamini-Hochberg correction is chosen)

my $minimal_number_of_reads=5;
my $maximal_percent_change=100;
my $file_test="test.txt"; # de-bugging output file

# end of input
my $string;
my $global_flag;
my %AUGC_counts;
my $was;
my $is;
my $current_levels;
my $previous_levels;
my $number_of_expressed_miRNA;
my $number_of_multiple_tests;
my $counter=0;
my $current_p_value;
my @p_values;
my @sorted_p_values;
my $length_p_values;
my $i;
my $number_of_reads;
my %hash_all_counts;
my $miR_name;
my $current_base;
my %num_of_letters_hash;
my @other_types;
my $max_is;
my $different_base;
my @all_miRs;
my @all_locations;
my $flag_new;
my $only_once;
my %hash_location_pvalue;
my $key;
my @array_expression=();
my %hash_max_expression;
my @array_values;
my $flag_start_of_read;
my $flag_order_of_magnitude_difference;
my $bonferroni_P_value;

#first file
open FILE_test, ">", $file_test or die $!;
open FILE_R, "<", $file1_name or die $!;
$string=<FILE_R>;
$counter=0;
$global_flag=1;

while ($global_flag==1)
{
    if ($string =~ /^[1,2].+?length:\s(\w+)/)
    {
        $counter++;
        $number_of_reads=$1-3;
        $current_base=substr($string,2,1);
        if (($number_of_reads>=$minimal_number_of_reads)&&($counter<=$max_position_to_check))
        {
            if (!($string=<FILE_R>))
            {
                $global_flag=0;
            }
            if ($string !~ /length:/)
            {
                if ($string =~ /([0-9]+)\t([0-9]+)\t([0-9]+)\t([0-9]+)/)
                {
                    $AUGC_counts{"A"}=$1;
                    $AUGC_counts{"U"}=$2;
                    $AUGC_counts{"G"}=$3;
                    $AUGC_counts{"C"}=$4;
                }
                if (!($string=<FILE_R>))
                {
                    $global_flag=0;
                }
                if ($string =~ /^([A|U|G|C]{2})\s:/)
                {
                    $was=substr($1,0,1);
                    $is=substr($1,1,1);
                    $current_levels=$AUGC_counts{$is};
                    $previous_levels=$AUGC_counts{"A"}+$AUGC_counts{"U"}+$AUGC_counts{"G"}+$AUGC_counts{"C"};
                    $hash_all_counts{$miR_name}{$counter}[0]=$was.$is;
                    $hash_all_counts{$miR_name}{$counter}[1]=$current_levels;
                    $hash_all_counts{$miR_name}{$counter}[2]=$previous_levels;
                    $flag_new=0;
                    #print FILE_test $miR_name,"\t",$counter,"\t",$hash_all_counts{$miR_name}{$counter}[0],"\t",$hash_all_counts{$miR_name}{$counter}[1],"\n";
                    if (!($string=<FILE_R>))
                    {
                        $global_flag=0;
                    }                    
                }
                else
                {
                    $previous_levels=$AUGC_counts{"A"}+$AUGC_counts{"U"}+$AUGC_counts{"G"}+$AUGC_counts{"C"};
                    %num_of_letters_hash=%AUGC_counts;
                    delete($num_of_letters_hash{$current_base});
                    @other_types=keys(%num_of_letters_hash);
                    $max_is=0;
                    foreach(@other_types)
                    {
                        if ($num_of_letters_hash{$_}>$max_is)
                        {
                            $max_is=$num_of_letters_hash{$_};
                            $different_base=$_;
                        }                  
                    }                    
                    $current_levels=$num_of_letters_hash{$different_base};
                    $hash_all_counts{$miR_name}{$counter}[0]=$current_base.$different_base;
                    $hash_all_counts{$miR_name}{$counter}[1]=$current_levels;
                    $hash_all_counts{$miR_name}{$counter}[2]=$previous_levels;
                    $flag_new=0;
                    #print FILE_test $miR_name,"\t",$counter,"\t",$hash_all_counts{$miR_name}{$counter}[0],"\t",$hash_all_counts{$miR_name}{$counter}[1],"\n";
                }
            }
            else
            {
                $current_levels=0;
                $previous_levels=$number_of_reads;
                $hash_all_counts{$miR_name}{$counter}[0]=$current_base.$current_base;
                $hash_all_counts{$miR_name}{$counter}[1]=$current_levels;
                $hash_all_counts{$miR_name}{$counter}[2]=$previous_levels;
                $flag_new=0;
                #print FILE_test $miR_name,"\t",$counter,"\t",$hash_all_counts{$miR_name}{$counter}[0],"\t",$hash_all_counts{$miR_name}{$counter}[1],"\n";
            }
        }
        else
        {
            if (!($string=<FILE_R>))
            {
                $global_flag=0;
            } 
        }
    }
    elsif ($string =~ /length:/)
    {
        $counter=0;
        if (($flag_new==0)&&($only_once==1))
        {
            $miR_name=$miR_name."-3p";
            $only_once=0;
        }
        if (!($string=<FILE_R>))
        {
            $global_flag=0;
        } 
    }
    else
    {
        if ($string =~ /[0-9]+\t([a-zA-Z]{3}.+?)\n/)
        {
            $miR_name=$1;
            $flag_new=1;
            $only_once=1;
        }
        if (!($string=<FILE_R>))
        {
            $global_flag=0;
        }
    }
}
close FILE_R;

@all_miRs=keys %hash_all_counts;
foreach(@all_miRs)
{
    $miR_name=$_; 
    @all_locations=keys %{$hash_all_counts{$miR_name}};
    foreach(@all_locations)
    {
        $counter=$_;
        if ((exists $hash_all_counts{$miR_name}{$counter}[1])&&(exists $hash_all_counts{$miR_name}{$counter}[2]))
        {
            print FILE_test $miR_name,"\t",$counter,"\t",$hash_all_counts{$miR_name}{$counter}[0],"\t";
            print FILE_test $miR_name,"\t",$counter,"\t",$hash_all_counts{$miR_name}{$counter}[1],"\t";
            print FILE_test $hash_all_counts{$miR_name}{$counter}[2],"\n";           
            $current_levels=$hash_all_counts{$miR_name}{$counter}[1];
            $previous_levels=$hash_all_counts{$miR_name}{$counter}[2];
            if ($current_levels>0)
            {
                $current_p_value=pbinom(($previous_levels-$current_levels),$previous_levels,(1-$p_mismatch));
                print FILE_test $miR_name,"\t",$counter,"\tP-val=",$current_p_value,"\n";
            }
            else
            {
                $current_p_value=1;
            }
            push(@p_values,$current_p_value);
            $hash_location_pvalue{$miR_name."\t".$counter."\t".$hash_all_counts{$miR_name}{$counter}[0]."\t".$current_levels."\t".$previous_levels}=$current_p_value;
            push(@array_expression,$previous_levels);
        }
    }
    $hash_max_expression{$miR_name}=max(@array_expression);
    @array_expression=();  
}
close FILE_test;

@sorted_p_values = sort {$a <=> $b} @p_values;
$length_p_values=$#sorted_p_values+1;
$bonferroni_P_value=$P_value/$length_p_values;
print "number of tests:\t",$length_p_values,"\n";
print "bonferroni P-value:\t",$bonferroni_P_value,"\n";
if ($BH_or_bonferroni eq "BH")
{
    $i=0;
    foreach $key (sort { $hash_location_pvalue{$a} <=> $hash_location_pvalue{$b}} keys %hash_location_pvalue)
    {
        if ($hash_location_pvalue{$key}<=(($i+1)*$P_value/$length_p_values))
        {
            @array_values=split("\t",$key);
            if ($hash_max_expression{$array_values[0]}>($array_values[4]*10))
            {
                $flag_order_of_magnitude_difference=1;
            }
            else
            {
                $flag_order_of_magnitude_difference=0;
            }
            if ($array_values[1]<=$first_N_bases)
            {
                $flag_start_of_read=1;
            }
            else
            {
                $flag_start_of_read=0;
            }
            if (($flag_start_of_read==0)||($flag_order_of_magnitude_difference==0))
            {
                print $key,"\t",$hash_location_pvalue{$key},"\n";
            }
            $i++;
        }
        else
        {
            last;
        }
    }
}
else
{
    foreach $key (sort { $hash_location_pvalue{$a} <=> $hash_location_pvalue{$b}} keys %hash_location_pvalue)
    {     
        if ($hash_location_pvalue{$key}<=$bonferroni_P_value)
        {
            @array_values=split("\t",$key);      
            if ($hash_max_expression{$array_values[0]}>($array_values[4]*10))
            {
                $flag_order_of_magnitude_difference=1;
            }
            else
            {
                $flag_order_of_magnitude_difference=0;
            }
            if ($array_values[1]<=$first_N_bases)
            {
                $flag_start_of_read=1;
            }
            else
            {
                $flag_start_of_read=0;
            }
            if (($flag_start_of_read==0)||($flag_order_of_magnitude_difference==0))
            {
                print $key,"\t",$hash_location_pvalue{$key},"\n";
            }
        }    
    }
}

#############################################################################################################################################
sub max {
    my @numbers = @_;
    my $max;
    my $running=-1;
    for($running=0;$running<=$#numbers;$running++)
    {
        if (defined($numbers[$running]))
        {
            $max = $numbers[$running];
            last;
        }
    } 
    
    for($running=0;$running<=$#numbers;$running++)
    {
        if (defined($numbers[$running]))
        {
            if ($numbers[$running] > $max)
            {
                $max = $numbers[$running];
            }
        }
    }
    return $max;
}
