#!/usr/perl/bin/
#usage programe.pl file.txt(having id of protein) outputfile
open(FH,$ARGV[0]);
open(FA,">".$ARGV[1]);
while($id=<FH>){
chomp($id);
$id=~s/\s+//g;
system "lynx -dump -width 500 \"http://www.uniprot.org/uniprot/$id.txt\">>human_phophoprotein_completedata.txt";close FA;
}
