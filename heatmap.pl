#!/usr/bin/perl -w
##################### usages  perl roc.pl columnefile     [column file may be aac or dpc comma seperated file]
if($ARGV[0] eq ""){print"\n\n@@@@@@@@@@@@@@@@ usages  perl heatmap.pl named_matrix_file     [mat file may be comma seperated file] @@@@@@@@@@@@@@@ \n\n";exit;}

$path=`pwd`;chomp $path;
open (FX,">heatmap.R");

print FX "library(gplots)\n";
print FX "library(marray)\n";

open(FH,"$path/$ARGV[0]");
$line=<FH>;
chomp $line;
@arr=split",", 
$line;$name=$arr[0];
$count=scalar(@arr);
print FX "nba \<\- read.csv(\"$path\/$ARGV[0]\", sep=\",\")\n";
print FX "row.names(nba) <- nba\$$name\n";
print FX "nba <- nba[,2:$count]\n";
print FX "nba_matrix <- data.matrix(nba)\n";
print FX "mcol <- maPalette(low=\"white\", high=\"green\",k=100)\n";

#print FX "nba_heatmap <- heatmap(nba_matrix, Rowv=NA, Colv=NA,col=mcol, scale=\"column\", margins=c(7,7))\n"; 
#print FX "nba_heatmap <- heatmap(nba_matrix, Rowv=NA, Colv=NA,col=greenred(1024), margins=c(7,7))\n"; 

print FX "nba_heatmap <- heatmap.2(nba_matrix,Rowv=FALSE,Colv=FALSE,col=mcol,dendrogram='none',cellnote=nba_matrix,notecol=\"black\",trace='none',key=False,lwid=c(.01,.99),lhei=c(.01,.99),margins=c(7,7),xlab=\"True family\",ylab=\"Predicted family\")\n";

#print FX "nba_heatmap<- heatmap(nba_matrix,trace=\"none\",col=greenred(1024))\n";
close FX;

system "R CMD BATCH heatmap.R";
system "rm heatmap.Rout heatmap.R";
