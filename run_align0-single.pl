#!/usr/bin/perl
$seq1=$ARGV[0];
$seq2=$ARGV[1];
open(FA1,">seq_n1");
open(FA2,">seq_n2");
open(FO1,$seq1);
open(FO2,$seq2);
@array221=<FO1>;
@array222=<FO2>;
foreach $seq1(@array221){
print FA1 $seq1;}
foreach $seq1(@array221){
print FA2 $seq2;}

system("~/Desktop/align0.exe seq_n1 seq_n2 >out1");
system "dos2unix out1";
open(FO,"out1");
@array=<FO>;close FA1,FA2,FO;
$se=join("#",@array);
$l4=~s/\s{7}//g;
$se=~s/\s/\*/g;
@array1=split("#",$se);
@align=();$sew='';$sew1='';$sew2='';$sew3='';$sew4='';
foreach $line(@array1){
    $l++;
    if($line=~/^seq_n1\*+(.+)\*/){

			 $sew.=$array1[$l-2];
                         $sew1.=$1;
                         $array1[$l]=~s/\*{7}//;chop($array1[$l]);
                         $sew2.=$array1[$l];
$array1[$l+1]=~s/\*{7}//;chop($array1[$l+1]);
                         $sew3.=$array1[$l+1];
                         $sew4.=$array1[$l+2];
    }
   }
$l1=$sew;$l2=$sew1;$l3=$sew2;$l4=$sew3;$l5=$sew4;
@u=split "\n",$sew;
print $l1,"\n",$l2,"\n",$l3,"\n",$l4,"\n",$l5;
print "\n";
$A=index($l2,"A");
$C=index($l2,"C");
$G=index($l2,"G");
$T=index($l2,"T");

sub max{ my $max = pop(@_); 
	 foreach (@_){ $max = $_ if $_ > $max; } 
	 $max; 
} 
sub min{ my $min = pop(@_); 
	 foreach (@_) { $min = $_ if $_ < $min;	 } 
	 $min; 
}
@large=($A,$C,$G,$T);
print min(@large);
print "\n";
$mi=min(@large);
$Ar=rindex($l2,"A");
$Cr=rindex($l2,"C");
$Gr=rindex($l2,"G");
$Tr=rindex($l2,"T");
@larger=($Ar,$Cr,$Gr,$Tr);
print max(@larger);
$m=max(@larger);
print "\n";
@seq2=split("",$l2);
@seq1=split("",$l1);@seq3=split("",$l3);@seq4=split("",$l4);@seq5=split("",$l5);
@align1=@seq1[$mi..$m];
@align2=@seq2[$mi..$m];
@align3=@seq3[$mi..$m];
@align4=@seq4[$mi..$m];
@align5=@seq5[$mi..$m];
print @align2;print "\n";
print @align3;print "\n";
print @align4;print "\n";
print @align;



#if($l2=~/.*([A-Z\-]+.+[A-Z]+)\-*/){print $1;}
__END__
$li1=$li2=$li3='';
while($line=<FO>){chomp($line);
if($line=~/seq_n1\s+(.+)\s+/){
$li1.=$1;
  $line=<FO>;
$line=~s/\r//g;
chomp($line);
$line=~s/\r//g;
$li2.=$line;
$line=<FO>;
chomp($line);
$line=~s/\r//g;
$li3.=$line;
}
}print "$li2\n$li3";

