#!/usr/bin/perl
# Translate a DNA sequence in all six reading frames
#use lib "/home/nishant/progs/sub";
#use FHAND;
#use "/home/nishant/progs/sub/sub.pm";
#@array=qw(3 2 1 4 12 3 16);

#@array=FHAND::ofr($ARGV[0]);
#print @array;
system "rm $ARGV[1]";
if($ARGV[0] eq ''){print 'ARGV[0]=Sfasta sequence file'."\n"."ARGV[1]=OUTput file\nARGV[2]=Window of sequence\nARGV[3]=Run on comp(1) or short motif(2)\n";}
else{
$i=0;
$window=$ARGV[2];
@array=opr($ARGV[0]);
#print @array;
foreach $line(@array){
chomp($line);
undef $add,$seq,@sind,@tind,@sites,$len1,$len;
@split=split("##",$line);
open(TEMP,">TEMP");
if(($ARGV[3] eq '1')||($ARGV[3] eq '')){
print TEMP "$split[0]\n$split[1]\n";
}
else{
$add=($window/2)+1;
$x='X' x $add;
$seq=$x.$split[1].$x;
#print $seq."\n";
undef @sind;
undef@tind;
undef @sites;
@sind=multi_index($seq,'s');
@tind=multi_index($seq,'t');
@sites=(@sind,@tind);
   foreach $site( @sites){
#   print $split[0]_$site
$org_site=$site-$add+1;
   $start=$site-(($window/2)+1);
   $subseq=substr($seq,$start,$window);
   print TEMP "$split[0]_$site\n$split[1]\n"; 
print  "$split[0]_$org_site\n$subseq\n";
   } 
}
#$split[1]=~s/X//g;
#print TEMP "$split[0]\n$split[1]\n";
close TEMP;
$len1=$window-1;
$len=$len1-1;
system "python ~/progs/PseAA.py 0.7 $len TEMP $ARGV[1]";
#print '.';
$i++;
if(($i%100) eq 0){print $i."...";}
#PseAA.py <WeightFactor> <LambdaVal> <input seq file> <output PseAAC file>


}
}









sub multi_index{
			my ($seq_in,$mot)=@_;
			my $pos1=0;
			my $pos=index($seq_in,$mot,$pos1);
			my $p=0;
			my @position=();
				while ($pos != -1) {
					#    print "Found $mot at $pos\n";
					$position[$p++]=$pos;
					my	$offset = $pos + 1;
					#print"$offset\n";
				    	$pos = index($seq_in,$mot,$offset);
			  	}
			#print $mot."\n";
			return @position;
}












sub opr
    {
        my($file) = @_;
        open FILE, "< $file" or die "Can't open $file : $!";
        my @file = <FILE>;
        close FILE;
        return wantarray ? @file : \@file;
    }
sub ofw
    {
        my ( $file, @content ) = @_;
        @content = () unless @content;
        open FILE, "> $file" or die "Can't open $file : $!";
        print FILE @content;
        close FILE;
    }

sub ofa
    {
        my ( $file, @content ) = @_;
        @content = () unless @content;
        open FILE, "> $file" or die "Can't open $file : $!";
        print FILE @content;
        close FILE;
    }
