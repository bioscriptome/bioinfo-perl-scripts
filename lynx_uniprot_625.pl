open(FH,$ARGV[0]);
$out=$ARGV[1];
@array=<FH>;
foreach $id (@array){
chomp($id);
#print "lynx - dump -width 500 "."http://www.uniprot.org/uniprot/?query=database%3A(type%3Aipi+$id)+AND+reviewed%3Ayes&sort=score"." >>$out";
system `lynx - dump -width 500 "http://www.uniprot.org/uniprot/?query=database%3A(type%3Aipi+$id)+AND+reviewed%3Ayes&sort=score" >>$out`;
}
