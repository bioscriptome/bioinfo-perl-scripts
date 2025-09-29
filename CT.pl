use Getopt::Std;
getopts('i:o:');
$file1=$opt_i;
$file2=$opt_o;
open(OUT,">$file2");
if($file1 ne '' && $file2 ne ''){
	open(FO,$file1);
	while($seq=<FO>){
		chomp($seq);
		@split=split('##',$seq);
		$sequence = $split[1];
		print $sequence."\n";
		$sequence=~ tr/RKEDQN/1/;$sequence =~ tr/GASTPHY/2/;$sequence=~ tr/CVLIMFW/3/;
		@porp1_cls1=countnum($sequence,"1");@porp1_cls2=countnum($sequence,"2");@porp1_cls3=countnum($sequence,"3");#countnum("RGCRGCRGCRGC","class i;e 1,2,3")
		print "$sequence\n@porp1_cls1 @porp1_cls2 @porp1_cls3";
		print OUT "$porp1_cls1[1],$porp1_cls2[1],$porp1_cls3[1]";
		@porp2_cls1=transitions($sequence,"12");@porp2_cls2=transitions($sequence,"21");@porp2_cls3=transitions($sequence,"23");@porp2_cls4=transitions($sequence,"32");@porp2_cls5=transitions($sequence,"31");@porp2_cls6=transitions($sequence,"13");#countnum("RGCRGCRGCRGC","transition between two class i;e 12,23,31,21,32,13")
                $p2c12=$porp2_cls1[1]+$porp2_cls2[1];
                $p2c34=$porp2_cls3[1]+$porp2_cls4[1];
                $p2c56=$porp2_cls5[1]+$porp2_cls6[1];
		print OUT ",$p2c12,$p2c34,$p2c56";	
                #print "\n$sequence\n12:@porp2_cls1\t21:@porp2_cls2\t23:@porp2_cls3\t32:@porp2_cls4\t31:@porp2_cls5\t13:@porp2_cls6\n";		
		print OUT "\n";
	        @parts=fraction($sequence);
		#print "\n@parts\n";
	}
}
else{
print "Prgrame for calculating compostion transition and distribution of properties of protein sequnce\n Usage: -i input sfasta format file\n-o output column file\n\n\t\t\t\tEnjoy Life !!!!!!!!!!!!!\n";
}






sub fraction{
my($line)=@_;
chomp($line);
undef @line3;undef $getsize;undef $p1;undef$p2;undef $p3;undef $p4;undef $p5;
@line3 = split(//,$line);
$getsize=$#line3;
for ($i=0;$i<(sprintf("%d",$getsize*0.125));$i++) {$p1.= $line3[$i];}
for ($i=sprintf("%d",$getsize*0.125);$i<(sprintf("%d",$getsize*0.25));$i++) {$p2 .= $line3[$i];}
for ($i=sprintf("%d",$getsize*0.25);$i<sprintf("%d",$getsize*0.50);$i++) {$p3 .= $line3[$i];}
for ($i=sprintf("%d",$getsize*0.5);$i<sprintf("%d",$getsize*0.75);$i++) {$p4 .= $line3[$i];}
for ($i=sprintf("%d",$getsize*0.75);$i<($getsize+1);$i++) {$p5 .= $line3[$i];}
@return=($p1,$p2,$p3,$p4,$p5);
#print "@return";
return @return;
}

sub countnum{
undef $total1;
undef $avg1;
undef @array1;
$total1=($_[0]=~s/$_[1]/$_[1]/g);
$avg1=sprintf("%2.2f",($total1*100)/length($_[0]));
@array1=($total1,$avg1);
return @array1;
}
sub transitions{
$num=$_[1];
$total=($_[0]=~s/$_[1]/$_[1]/g);
$_[0]=~s/\#/$_[1]/g;
undef $avg;
undef @array;
$avg=sprintf("%2.2f",(($total*100)/(length($_[0])-1)));
@array=($total,$avg);
undef $total;
return @array;

}
