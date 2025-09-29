# Column 1: Class assignment - B for buried or E for Exposed - Threshold: 25% exposure, but not based on RSA
# Column 2: Amino acid
# Column 3: Sequence name
# Column 4: Amino acid number
# Column 5: Relative Surface Accessibility - RSA
# Column 6: Absolute Surface Accessibility
# Column 7: Z-fit score
# Column 8: Probability for Alpha-Helix
# Column 9: Probability for Beta-strand
# Column 10: Probability for Coil
#E M  GDNF_HUMAN             1    0.652 130.565  -0.392   0.003   0.003   0.994

use Getopt::Std;
getopts('i:o:w:t:h:c:');

$file1=$opt_i;
$file2=$opt_o;
$sym=$opt_s;
$window=$opt_w;
$type=$opt_t;
$column=$opt_c;
if($file1 eq ""|$opt_h ne ''){
print "# usage: perl run_netsurf.pl -i <lc_sfasta> -o <output_file> -w <window_size> -t <type_of_output c|s> -c <column_numerb>\n";
print "-i: sfasta lc interacting res
-o: output file
-w: window size
-t: type of output column or svm
-c: column number 
   :- Column 1: Class assignment - B for buried or E for Exposed - Threshold: 25% exposure, but not based on RSA
   :- Column 2: Amino acid
   :- Column 3: Sequence name
   :- Column 4: Amino acid number
   :- Column 5: Relative Surface Accessibility - RSA
   :- Column 6: Absolute Surface Accessibility
   :- Column 7: Z-fit score
   :- Column 8: Probability for Alpha-Helix
   :- Column 9: Probability for Beta-strand
   :- Column 10: Probability for Coil
";
}
else{
system "perl ~/gpsr_1.0/bin/fasta2sfasta_mod -i $file1 -o SFASTA";

open(OUT,">$file2.col");
open(FH,$file1);
@file1=<FH>;
close FH;
if(-e $file2){print "file exixts!!!!!!!!!\nRemove $file2 file\n";}else{ system "~/softy/netsurfp-1.0/netsurfp -i $file1 -a >$file2";}
system "sed 's/ \\+/\\t/g' $file2>TEMP.tab";
 @unique=`grep -v '^#' TEMP.tab |cut -f3|sort -u`;
$size=scalar(@unique);
system "grep -v '^#' TEMP.tab >COL";
open(TAB,"COL");
open(TAB1,">TEMP1.tab");

@tab=<TAB>;
close TAB;
foreach $tab(@tab){
chomp($tab);@sep=split("\t",$tab);print TAB1 "$sep[3]\t$sep[0]\t$sep[1]\t$sep[2]\t$sep[4]\t$sep[5]\t$sep[6]\t$sep[7]\t$sep[8]\t$sep[9]\t$sep[10]\n";
}
close TAB1;
foreach $name(@unique){
chomp($name);
$hname=$name;
#system "perl -n -e '$line=$_;chomp($line);'"
@grep_id=`grep $name TEMP1.tab|cut -f1,$column`;
$size=@grep_id;
undef %hash;
foreach $gid(@grep_id){
chomp($gid);
#print "$gid\n";
@split=split("\t",$gid);
$split[0]=~s/\s//g;
$split[1]=~s/\s//g;

$hash{$split[0]}=$split[1];
}
%{"$hname"}=%hash;
}
#print keys %{$unique[0]};
print "Program Running !!!!!!!!!!!!!!!";

foreach $name(@unique){
print "..";
chomp($name);
$n=$name;
#print $n;
%ret1=%{"$n"};
undef $line1;undef $line2;
foreach my $key (sort { $a <=> $b} keys  %ret1) {
#print $key."\t";
#    print $key."\t".$ret1{$key} . "\n";
$line1.="$key,";$line2.=$ret1{$key}.",";
}
#system "perl ~/gpsr_1.0/bin/fasta2sfasta_mod -i $file1 -o SFASTA";
$grep=`grep $name SFASTA`;

#print $grep;
chomp($grep);
@grep_s=split("##",$grep);

print OUT ">$name##$grep_s[1]##$line1"."@".$line2."\n";
@ret=keys %{"$n"};
#foreach $r(@ret){
#print"$r\n";}
}
print "\n";
close OUT;
open(PAT,"$file2.col");
@pat=<PAT>;
close PAT;
foreach $pat(@pat){
chomp($pat);
@pattern=split("##",$pat);
$pid=$pattern[0];
undef $sequence;
$sequence=$pattern[1];
@split_a=split("@",$pattern[2]);
undef $prop;
$prop=$split_a[1];
#print "$pid#$sequence#$prop\n";
$add=($window-1)/2;
$start=$site-$add;
$end=$site+$add;
$add_x='X' x $add;
$add_p='0,' x $add;
$add_p_e='0,' x $add;
$prop=$add_p.$prop.$add_p_e;
$sequence=$add_x.$sequence.$add_x;
@sequence=split("",$sequence);

@prop=split(",",$prop);
@s=multi_index($sequence,'s');
@t=multi_index($sequence,'t');
@sites=(@s,@t);
@sorted_sites=sort {$a <=> $b} @sites;
foreach $site(@sorted_sites){
chomp($site);
$add=($window-1)/2;
$start=$site-$add;
$end=$site+$add;
#if($site<$add){$fin_seq=$}
@colum= @prop[$start...$end];
@column1=split("",$colum);
$join_c=join(",",@colum);
print $pid."\t$site\t";print @sequence[$start...$end];print "\t";print $join_c;print "\n";
}
}


}

sub multi_index{
                        my ($seq_in,$mot)=@_;
                        my $pos1=0;
                        my $pos=index($seq_in,$mot,$pos1);
                        my $p=0;
                        my @position=();
                                while ($pos != -1) {
                                        #    print "Found $mot at $pos\n";
                                        $position[$p++]=$pos;
                                        my      $offset = $pos + 1;
                                        #print"$offset\n";
                                        $pos = index($seq_in,$mot,$offset);
                                }
                        #print $mot."\n";
                        return @position;
}
