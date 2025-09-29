#!/usr/bin/perl
use Getopt::Std;
getopts('p:n:w:o:');
$prosrch=$opt_p;#positive lower case sfasta
$srchin=$opt_n;#negative lower case sfasta
$win=$opt_w;
$output=$opt_o;
if($prosrch eq ''|| $srchin eq ''){print '-p:File having proteins sequences to search (sfasta format)
-n:File having proteins sequences to search in the query proteins (sfasta format)
-w:Define peptide size(11,13,15)
-o:Output file
'."\n"
}else{
    open(OUT,">$output");
    open(FP1,"$prosrch");
    @pro2srch=<FP1>;
    open(FP2,"$srchin");
    @srchinpro=<FP2>;
    close FP1,FP2;
    foreach $pro2srch(@pro2srch){
       chomp($pro2srch);
       @parts= split("##",$pro2srch);
       $protein=$parts[1];
       
       for($i=0;$i<((length($protein))-$win+1);$i++){
          $pep=substr($protein,$i,$win);
          foreach $srchinpro(@srchinpro){
             chomp($srchinpro);
             @parts2= split("##",$srchinpro);
             if($parts2[1]=~/$pep/){
             @ret=multi_index($parts2[1],$pep);
             $parts[0]=~s/>//g;$parts2[0]=~s/>//g;
             print OUT  "$parts[0]\t$i\t$pep\t$parts2[0]\t@ret\n";
             
             }
       
       }
    }
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


