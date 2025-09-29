open(FH,$ARGV[0]);#o_res_file
open(FH1,$ARGV[1]);#bin_file
open(FA,">".$ARGV[2]);#ouput_svm_file
@ores=<FH>;
@bin=<FH1>;
    close FH,FH1;$line=0;
foreach $ores(@ores){
chomp($ores);
open(FO,">temp_bin");
print FO $bin[$line++];
close FO;
system "perl ~/gpsr_1.0/bin/col2svm -i temp_bin -o svm_temp -s $ores";
open(FS,"svm_temp");@svm=<FS>;close FS;
print FA  $svm[0];
system "rm svm_temp temp_bin";
}

