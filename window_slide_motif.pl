#!/usr/bin/perl 
use Getopt::Std;
getopts('i:w:o:s:e:');
$file=$opt_i;
$window=$opt_w;
$bin=$opt_o;
$start=$opt_s;
$ending=$opt_e;
if($file eq '' || $window eq ''|| $bin eq ''||$start eq ''||$ending eq ''){
print '$opt_i;input motif file
$opt_w;windows size to be generated
$opt_o;outputfile
$opt_s;starting position from where sliding windows is to be created 
$opt_e;ending position of the windows write number like u r starting numbering from the right sied'."\n";
}


else{

if ($file ne '' && $bin ne '' && $window ne '') {
open(FP1,"$file");
#open(FP2,">$bin"); 
$d1=0;
while($t1=<FP1>){
    chomp($t1);
   
 $c1 = substr($t1,0,1);
    if($t1 =~ ">"){print FP2 $t1."\n";}
else
{	$t1=~s/\s//g;
	$len=length($t1);
	$end1=$len-$start-$ending;
	$end=$end1-$window+1;
	for($i=0;$i<=$end;$i++){
		$sub=substr($t1,$i+$start-1,$window);
		$array2d[$d1][$i]=$sub;
	}
	
		}
		$d1++;
	}
}

system "rm ".$bin."*";
foreach $item1 (@array2d){
$m=1;	
	$u=@{$item1};
	foreach $item2 (@{$item1}){
	  open(FA,">>$bin".$m++);
    print FA "$item2\n";  
  }
 # print "\n";
  
}

#print scalar(@array2d);
}
__END__



else 

