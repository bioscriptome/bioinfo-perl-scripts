 $oldlastcol = 0;
 $lastcol = 0;
 @outline;

 $file =$ARGV[0] or die USAGE;

if (not -e $file) {
    die "Can\'t find $file: $!\n";
}

open (IN, "$file") or die "Can\t open $file: $!\n";
open(FA,">".$ARGV[1]);
while (<IN>) {
     chomp;
      @line = split /\t/;
     $oldlastcol = $lastcol;
     $lastcol = $#line if $#line > $lastcol;
     for ( $i=$oldlastcol; $i < $lastcol; $i++) {
          $outline[$i] = "\t" x $oldlastcol;
     }
    for ( $i=0; $i <=$lastcol; $i++) {
         $outline[$i] .= "$line[$i]\t"
    }
}

for ( $i=0; $i <= $lastcol; $i++) {
     $outline[$i] =~ s/\s*$//g;
     print FA $outline[$i]."\n";
}
