#usage perl program.pl file_having_large_noofmotif file_having_less_motif outfile_having_unique_motif outfile_having_comman_motif
open(FH,$ARGV[0]);
open(FH1,$ARGV[1]);
open(FA,">".$ARGV[2]);
open(FA1,">".$ARGV[3]);
$sfasta=$ARGV[3];
$sfasta=~s/\..+//;
@file1=<FH>;
@file2=<FH1>;
close FH,FH1;
$line=0;
$file_1=join("##",@file1);
foreach $file2(@file2){
    chomp($file2);
    $file_1=~s/\s//g;
    if($file_1=~/$file2/g){print FA $file2."\n";}
    $file_1=~s/$file2/@/g;
    $file_1=~s/##@##/##/g;
    
}

@file_1=split("##",$file_1);

foreach $file1(@file_1)
{
    print FA1 $file1."\n";
}

system "perl ../../../../gpsr_1.0/bin/fasta2sfasta_mod -i $ARGV[3] -o $sfasta.sfasta ";






__END__
    foreach $file1(@file1){
chomp($file1);$line++;
foreach $file2(@file2){
    chomp($file2);
    if($file1 eq $file2){print FA $line."\n";}
    else{$unique=$file1."\n";
}
    } print FA1 $unique;
}

