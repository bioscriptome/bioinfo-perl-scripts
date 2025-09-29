if($ARGV[0] eq ''){print "ARGV[0]: Tab seprated id and Geo Terms file\nARGV[1]: Sfasta Sequence File\nARGV[2]: output file\n";}
open(FH,$ARGV[0]);
@go=`cut -f2 $ARGV[0]|sort -u`;
@go1=map{chomp} @go;
@id=`cut -f1 $ARGV[0]|sort -u`;
@id1=map{chomp} @id;
#print @go;
@array=<FH>;
open(OUT,">OUT_T");
foreach $id(@id){
print OUT $id."##";
foreach $line(@array){
chomp($line);
@split_line=split("\t",$line);
if($split_line[0] eq $id){print OUT $split_line[1]."\t";}
}
print OUT "\n";
}
chomp($line);


foreach $g(@go){
        print $g."#";
          }
print "\n";

open(FH1,"OUT_T");
@GO2bin=<FH1>;
foreach $l1(@GO2bin){
	chomp($l1);
	@split=split("##",$l1);
	@bin=split("\t",$split[1]);
        print "$split[0]\t";
	foreach $g(@go){
                undef $term;
        	#if($g eq $split[])
               	foreach $b(@bin){
		 if($b eq $g){$term=1;}
		}
         if($term eq 1){print $term.",";}
         else{print "0,";}
	}
        print "\n";
}



open(FH1,$ARGV[1]);


sub count_unique { #counting unique keys
    my @array = @_;
    my %count;
    map { $count{$_}++ } @array;

      #print them out:

#    map {print "$_\t${count{$_}}\n"} sort keys(%count);
@uni_id=keys(%count);
      #or just return the hash:

    return @uni_id;
}




