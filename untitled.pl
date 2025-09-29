 #!/usr/bin/perl
open(FH,"2.txt");
while($line=<FH>){
for (my $key = 0; $key < length($line); $key+=21) {
#print 
$mot=substr ($line, $key, 21);
if(length($mot)==21){print $mot."\n";}
}}
