open(FH,$ARGV[0]);
@list=<FH>;
close FH;
$pwd=`pwd`;
chomp($pwd);

print "\n\n\n".$pwd."\n\n\n\n";
foreach $line(@list){
chomp($line);
chdir("$pwd/$line");
#@list=
#`ls *`;
#print "##";
#print @list."##\n";
print "$pwd/$line/run\n";
system "mkdir $pwd/$line/run";
chdir("$pwd/$line/run");
system "ls $pwd/$line/ |grep .svm>ls321";

#opendir(DIR, "$pwd/$linei");
#@l= readdir(DIR);
#close DIR;
open(FH,"ls321");
@l=<FH>;
close FH;
print "|| @l ||";
chomp($l[0]);
chomp($l[1]);
print "perl /home/nishant/progs/shuffle.pl ../$l[0] ../$l[1]";
system "perl /home/nishant/progs/shuffle.pl ../$l[0] ../$l[1]";
print "\n$pwd/$line/run !!!!\n";
chdir($pwd);
print $pwd."@@@@\n";
}
