#!/usr/bin/perl
if($ARGV[0] eq '' || $ARGV[1] eq '' || $ARGV[2] eq '' || $ARGV[3] eq ''){print "perl split_5fold <POSITIVE FILE> <NEGATIVE file> <POS_NAME> <NEG_NAME>\n";}
if($ARGV[0] ne '' && $ARGV[1] ne '' && $ARGV[2] ne '' &&$ARGV[3] ne ''){
$file =$ARGV[0];
$setname=$ARGV[2];
$i=0;
open(FH,"$file");
    open (FP, ">$setname"."1.svm");
    open (FP1, ">$setname"."2.svm");
    open (FP2, ">$setname"."3.svm");
    open (FP3, ">$setname".'4.svm');
    open (FP4, ">$setname".'5.svm');
undef @seq;
while ($line=<FH>){
   chomp($line);
   $seq[$i] = $line;
   $i++;
}
   for ($i=0;$i<@seq;$i++){
    $n=$i;
    if ($n>4){
	$n= $n%5;
    }
    if ($n==0){
    print FP "$seq[$i]\n";
}     
    if ($n==1){
    print FP1 "$seq[$i]\n";
}
    if ($n==2){
    print FP2 "$seq[$i]\n";
}
    if ($n==3){
    print FP3 "$seq[$i]\n";
}
    if ($n==4){
    print FP4 "$seq[$i]\n";
} 
}
close FH,FP,FP1,FP2,FP3,FP4;
$file1 =$ARGV[1];
$setname=$ARGV[3];
open(FH1,"$file1");
    open (FPn, ">$setname"."1.svm");
    open (FP1n, ">$setname"."2.svm");
    open (FP2n, ">$setname"."3.svm");
    open (FP3n, ">$setname".'4.svm');
    open (FP4n, ">$setname".'5.svm');
undef @seq;
$i=0;
while ($line=<FH1>){
   chomp($line);
   $seq[$i] = $line;
   $i++;
}
   for ($i=0;$i<@seq;$i++){
    $n=$i;
    if ($n>4){
	$n= $n%5;
    }
    if ($n==0){
    print FPn "$seq[$i]\n";
}     
    if ($n==1){
    print FP1n "$seq[$i]\n";
}
    if ($n==2){
    print FP2n "$seq[$i]\n";
}
    if ($n==3){
    print FP3n "$seq[$i]\n";
}
    if ($n==4){
    print FP4n "$seq[$i]\n";
} 
}
}
close FH1,FPn,FP1n,FP2n,FP3n,FP4n;

system "mkdir set_1 set_2 set_3 set_4 set_5";
system " perl /home/nishant/progs/shuffle.pl  pos1.svm neg1.svm";
system "mv train_* set_1/.";
system "mv test_* set_1/.";
system " perl /home/nishant/progs/shuffle.pl  pos2.svm neg2.svm";
system "mv train_* set_2/.";
system "mv test_* set_2/.";
system " perl /home/nishant/progs/shuffle.pl  pos3.svm neg3.svm";
system "mv test_* set_3/.";
system "mv train_* set_3/.";
system " perl /home/nishant/progs/shuffle.pl  pos4.svm neg4.svm";
system "mv train_* set_4/.";
system "mv test_* set_4/.";
system " perl /home/nishant/progs/shuffle.pl  pos5.svm neg5.svm";
system "mv train_* set_5/.";
system "mv test_* set_5/.";
exit;
