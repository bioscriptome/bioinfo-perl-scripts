#!/usr/bin/perl 
use Getopt::Std;
getopts('i:o:l:m:');
$sfasta=$opt_i;
$output=$opt_o;
$list=$opt_l;
$prop_matrix=$opt_m;
$aa = "#ACDEFGHIKLMNPQRSTVWY";
if($sfasta eq ''){print "#usage -i input-sfasta -o output file -l prop_list -m prop_matrix\n";}
else{ open(SFASTA,"$sfasta");
            undef @matrix;$num=0;
            while($line=<SFASTA>){chomp($line);$add_freq='';
               if($line=~'^>'){
                    @splitline=split("##",$line);
                    @RES = split("",$splitline[1]);
	            for($i=1; $i <= 20; $i++){$freq[$i]=0;}
	            foreach $res(@RES){$pos = index($aa,$res);$freq[$pos]++;}
	            for($j=1; $j <= 20; $j++){if($j <= 19){$add_freq.="$freq[$j]\t";}else{$add_freq.="$freq[$j]";}}
	      } $matrix[$num++]=$add_freq;#print $matrix[$num-1]."\n"; 
          }

open(FOUT,">$output");
open(MATRIX,$prop_matrix);
@prop_matrix=<MATRIX>;
close MATRIX;
undef %matrix;
foreach $mat(@prop_matrix){chomp($mat);@split_mat=split("##",$mat);$matrix{$split_mat[0]}=$split_mat[1];}
#print $matrix{"ZIMJ680105"};
open(LIST,$list);@list=<LIST>;close LIST;
foreach $seq_freq(@matrix){
        chomp($seq_freq);
        undef @aa_prop;undef @aa_freq;
##print "$seq_freq";
        foreach $list(@list){ 
        chomp($list);
#print $list;
undef @aa_prop;undef @aa_freq;
 undef  $ret_prop_val;undef @aa_prop;
        $ret_prop_val=$matrix{$list};
#print $ret_prop_val."\n";
        @aa_prop=split("\t",$ret_prop_val);
        @aa_freq=split("\t",$seq_freq);
        undef @avg;
        for($m=0;$m<20;$m++){
#print "$aa_prop[$m]*$aa_freq[$m]\t ";
        $avg[$m]=$aa_prop[$m]*$aa_freq[$m];
        }
        undef $prop_mean;
        $prop_mean = do {  $s1=0; $s1 += $_ for @avg; $s1/@avg };
        printf(FOUT "%2.4f,",$prop_mean);

        }
        print FOUT "\n";
}
}

sub mean{
undef @mean;
@mean=@_;
undef $sub_mean;
 $sub_mean = do {  $s; $s += $_ for @mean; $s /@mean };
 return $sub_mean;
 }
