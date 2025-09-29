if($ARGV[0] eq ''){print "Programe to find the comman and unique sites in two datasetrs;";}
system "sort -u $ARGV[0] >temp_s1";
system "sort -u $ARGV[1] >temp_s2";
open(FH1,"temp_s1");
open(FH2,"temp_s2");
open(FOUND,">site_f");
open(NF,">site_u");
@ds1=<FH1>;
@ds2=<FH2>;
close FH1,FH2;
foreach $ds1(@ds1){
        chomp($ds1);
        @splitds1=split("##",$ds1);
        foreach $ds2(@ds2){
                chomp($ds2);
                @splitds2=split("##",$ds2);
                        if($splitds1[0]=~/$splitds2[0]/){
                        @sites1=split("\t",$splitds1[1]);
                        @sites2=split("\t",$splitds2[1]);
                        foreach $site1(@sites1){
			#print $site1;
                          if ( grep { $_ eq "$site1"} @sites2 ) {
                                print FOUND"$splitds1[0] $site1\n"; $add++
                          }
			else{print NF "$splitds1[0] $site1\n"; $nf++; }
                          }
                        }
        }

}
system `sort -u site_f >$ARGV[0].comman`;
system `sort -u site_u >$ARGV[0].unique`;
$com=`wc -l $ARGV[0].comman`;
$uni=`wc -l $ARGV[0].unique`;
print $com." sites are comman and are sent to $ARGV[0].comman\n";
print $uni." sites are unique and are sent to $ARGV[0].unique\n";
system "rm site_f site_u  temp_s1 temp_s2";
