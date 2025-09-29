open(FH,$ARGV[0]);
@array=<FH>;
map{chomp}@array;
close FH;
%hash=count_unique(@array);
foreach $key(keys %hash){
#print $key."\t".$hash{$key}."\n";

}








sub count_unique { #counting unique keys
    my @array = @_;
    my %count;
    map { $count{$_}++ } @array;

      #print them out:

    map {print "$_ = ${count{$_}}\n"} sort keys(%count);

      #or just return the hash:

    return %count;
}

