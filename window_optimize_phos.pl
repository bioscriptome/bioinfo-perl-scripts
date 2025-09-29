if($ARGV[0] eq ''){print "\$ARGV[0] input lc sfasta \n\$ARGV[1] id_position file";}
@window=qw(3 5 7 9 11 13 15 17 19 21 23);
$sym=$ARGV[2];
foreach $win(@window){
    system "mkdir $win $win\/pos_dis $win\/binary $win\/mot $win\/pos_bin";
    system "cp $ARGV[0] id_pos_$sym";
    system "cp $ARGV[1] id_seq_$sym";
    chomp($win);
    system "perl ~/progs/run_VSL2.pl id_seq_$sym id_pos_$sym $win";
    system "mv *.DIS $win\/pos_dis\/.";
	system "mv *.mot $win\/mot\/.";
    system "perl ~/gpsr_1.0/bin/motif2bin -i $win\/mot\/id_pos_$sym.mot -o $win\/binary/id_pos_$sym\/.bin -x y";

}
