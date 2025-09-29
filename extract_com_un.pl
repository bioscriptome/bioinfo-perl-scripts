print "usage perl program.pl file_having_large_noofmotif file_having_less_motif outfile_having_comman_motif outfile_having_unique_motif\n";
open(FH,$ARGV[0]);
system `sort -u $ARGV[0] >temp1`;
open(FH1,"temp1");
open(FH1,$ARGV[1]);
system `sort -u $ARGV[1] >temp2`;
open(FH1,"temp2");
open(FA,">".$ARGV[2]);
open(FA1,">".$ARGV[3]);
@file1=<FH>;@file2=<FH1>;
close FH,FH1;
$file_x=join("@",@file1);
$file_x='@'.$file_x.'@';
$file_x=~s/\n//g;
foreach $file_y(@file2){
    chomp($file_y);
    if($file_x=~/\@$file_y\@/){print FA $file_y."\n";
    $file_x=~s/$file_y/\#/g;
    $file_x=~s/\@\#\@/@/g;
    }
}
print $file_x;
@file_1=split("@",$file_x);
foreach $file1(@file_1)
{
    print FA1 $file1."\n";
}
system `rm temp1 temp2`;
system `grep \[0-9a-zA_z\] $ARGV[3] >out-t`;
system `mv out-t $ARGV[3]`;
exit;
