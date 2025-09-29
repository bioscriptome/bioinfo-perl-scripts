#!/usr/bin/perl
#------------------------------------------
# This allow to create at network file for snns
#-------------------------------------------
print "------------- Start ---------- \n";
print "Please entre name of file to be created: ";
$file=<>;
chomp($file);
print "\n Enter name of network (optional): ";
$netname=<>;
chomp($netname);

print "\n Entre size of window (secondary structure): ";
$wsize=<>;
chomp($wsize);
print "\n Number of inputs at a position :";
$unit=<>;
chomp($unit);
print "\n Enter number of hidden nodes :";
$hlayer =<>;
chomp($lay);
print "\n Enter number of output units :";
$out=<>;
chomp($out);
print "\n";
open(FP1,">$file");
print FP1 "SNNS network definition file V1.4-3D\n";
print FP1 "generated at Thu Oct 25 11:04:32 2001\n";
print FP1 "\n";
print FP1 "network name : $netname\n";
print FP1 "source files :\n";
$iunit=$wsize*$unit;
$conn= $iunit*$hlayer+$hlayer*$out;
$tot=$iunit+$hlayer+$out;
print FP1 "no. of units : $tot\n";
print FP1 "no. of connections : $conn\n";
print FP1 "no. of unit types : 0\n";
print FP1 "no. of site types : 0\n";
print FP1 "\n";
print FP1 "\n";
print FP1 "learning function : Std_Backpropagation\n";
print FP1 "update function   : Random_Order\n";
print FP1 "\n";
print FP1 "\n";
print FP1 "unit default section :\n";
print FP1 "\n";
print FP1 "act      | bias     | st | subnet | layer | act func     | out func\n";
print FP1 "---------|----------|----|--------|-------|--------------|-------------\n";
print FP1 " 0.00000 |  0.00000 | h  |      0 |     1 | Act_Logistic | Out_Identity\n";
print FP1 "---------|----------|----|--------|-------|--------------|-------------\n";
print FP1 "\n";
print FP1 "\n";
print FP1 "unit definition section :\n";
print FP1 "\n";
print FP1 "no. | typeName | unitName | act      | bias     | st | position | act func | out func | sites\n";
print FP1 "------|----------|----------|----------|----------|----|----------|----------|----------|-------\n";
$sn=0;
$type="";
$act=1.0;
$bias=0.0;
$w1=0;
for($i1=1; $i1<=$wsize; $i1++){
for($i2=1; $i2<=$unit; $i2++){
    $sn++;
    printf(FP1 "%5d | %8s |u%d%d   | %8.4f | %-8.4f | i | %d,%d,%d |||\n",$sn,$type,$i2,$i1,$act,$bias,$i1,$i2,$w1);
}
}

for($i3=1; $i3<=$hlayer; $i3++){
    $sn++;
    printf(FP1 "%5d | %8s | h%-5d| %8.4f | %-8.4f | h | %d,%d,%d |||\n",$sn,$type,$i3,$act,$bias,$i2,$i3-1,$w1);
}


for($i4=1; $i4<=$out; $i4++){
    $sn++;
    printf(FP1 "%5d | %8s | o%d    | %8.4f | %-8.4f | o | %d,%d,%d |||\n",$sn,$type,$i4,$act,$bias,$hlayer+$i4,$i4,$w1);
}

print FP1 "----|----------|----------|----------|----------|----|----------|----------|----------|-------\n";
print FP1 "\n";
print FP1 "\n";
print FP1 "connection definition section :\n";
print FP1 "\n";
print FP1 "target | site | source:weight\n";
print FP1 "-------|------|---------------------------------------------------------------------------------------------------------------------\n";

for($i3=1; $i3<=$hlayer; $i3++){
    $sn = $iunit+$i3;
    printf(FP1 " %5d |      |",$sn);
$sn1 = 0;
for($i1=1; $i1<=$wsize; $i1++){
for($i2=1; $i2<=$unit; $i2++){
    $sn1++;
    $lab=(($i2-1)*$wsize)+$i1;
    $val=(rand(1000) - 500)/100;
    if($lab < $iunit){printf(FP1 "%3d:%-7.5f,",$lab,$val);}else{printf(FP1 "%3d:%-7.5f",$lab,$val)}

    if(($sn1 % 9) == 0){print FP1 "\n               ";} 

}
}
    print FP1 "\n";

}


for($i4=1; $i4<=$out; $i4++){
    $sn=$iunit+$hlayer+$i4;
    printf(FP1 " %5d |      |",$sn);
for($i3=0; $i3< $hlayer; $i3++){
    $lab=$iunit+$hlayer-$i3;
    $val=(rand(1000) - 500)/100;
 if($lab > (1+$iunit)){printf(FP1 "%4d:%6.4f,",$lab,$val);}else{printf(FP1 "%5d: %6.3f",$lab,$val)}
if((($i3+1) % 9) == 0){print FP1 "\n";} 
}

print FP1 "\n"; 


}


print FP1 "-------|------|---------------------------------------------------------------------------------------------------------------------\n";

close FP1;






