#!/usr/bin/perl
sub fas {
my @fastdata=@_;
my $seq='';
unless (open(FH, "fas.csv")){print "error\n";exit;}
@fastdata=<FH>;
close FH;
foreach my $line (@fastdata){
chomp $line;
if ($line=~/^>/){next;}
else{$seq.=$line;}
}
$seq=~s/\s//g;
return $seq;
}
print fas();
