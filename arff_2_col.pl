$arff=$ARGV[0];#arff file to be converted back into column file
$pos=$ARGV[1];#positive filr to be genrated from arff
$neg=$ARGV[2];#negative filr to be genrated from arff
open(ARFF,$arff);
open(NEG,">$pos");
open(POS,">$neg");
@arff=<ARFF>;
foreach $col_line(@arff){
if($col_line=~/^\d+/){
@col=split(",",$col_line);
$last=scalar(@col);
chomp($col[$last-1]);
if($col[$last-1]=~/positive/){$col_line=~s/,positive//g;print POS $col_line;}
if($col[$last-1]=~/negative/){$col_line=~s/,negative//g;print NEG $col_line;}

}}
