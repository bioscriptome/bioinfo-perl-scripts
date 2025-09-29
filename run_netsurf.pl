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
print "-i: fasta lc interacting res
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
  @grep_id=`grep $name TEMP1.tab|cut -f1,$column`;
  $size=@grep_id;
  undef %hash;
  foreach $gid(@grep_id){
    chomp($gid);
    @split=split("\t",$gid);
    $split[0]=~s/\s//g;
    $split[1]=~s/\s//g;
    $hash{$split[0]}=$split[1];
    }
  %{"$hname"}=%hash;
  }
  print "Program Running !!!!!!!!!!!!!!!";
  foreach $name(@unique){
    print "..";
    chomp($name);
    $n=$name;
    %ret1=%{"$n"};
    undef $line1;undef $line2;
    foreach my $key (sort { $a <=> $b} keys  %ret1) {
         $line1.="$key,";$line2.=$ret1{$key}.",";
     }
    #system "perl ~/gpsr_1.0/bin/fasta2sfasta_mod -i $file1 -o SFASTA";
    $grep=`grep $name SFASTA`;
    chomp($grep);
    @grep_s=split("##",$grep);
    print OUT ">$name##$grep_s[1]##$line1"."@".$line2."\n";
    @ret=keys %{"$n"};
    #foreach $r(@ret){
    #print"$r\n";}
  }
  print "\n$size";
  close OUT;
}
