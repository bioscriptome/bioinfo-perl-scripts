#!/usr/bin/perl -w

$file1=$ARGV[0];
$fold=$ARGV[1];

for($i1=1; $i1 <= $fold; $i1++){
		$count = $i1 - 1;
		
		open(FR1,">test$i1.dat");
		open(FR2,">train$i1.dat");
                open(FP1,"$file1");
		while($t1=<FP1>){
		    if(($count%$fold) == 0){print FR1 $t1;} else{print FR2 $t1;}
		    $count++;
		}
		close FP1;
		close FR1;
		close FR2;
}
