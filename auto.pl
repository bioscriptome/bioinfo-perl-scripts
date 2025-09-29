
#Give any type of input like aac or dpc or physicochemical properties in argv 0 as positive
# and give in argv 1 as negative and in argv 2 the class of name of group like IgG or IgE.
# example perl auto.pl Gposdpc Gnegdpc IgG

$path="$ARGV[3]";#system $path;
system "perl $path/col2svm.pl -i $ARGV[0] -o $path/$ARGV[2]psvm -s +1";

system "perl $path/col2svm.pl -i $ARGV[1] -o $path/$ARGV[2]nsvm -s -1";

system "perl $path/mix_p_n.pl $path/$ARGV[2]psvm $path/$ARGV[2]nsvm $path/$ARGV[2]mix";
system "perl $path/five_sets.pl $path/$ARGV[2]mix $path";
system "perl $path/tr_test.pl $path";

