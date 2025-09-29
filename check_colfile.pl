
open(FH,$ARGV[0]);
@array=<FH>;
close FH;
$c=0;
foreach $line(@array){
$count=($line=~tr/,//);
$c++;
print "$c\t$count\n";
$count[$c]=$count;
}

%hash=count_unique(@count);
foreach $key(keys %hash){
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

