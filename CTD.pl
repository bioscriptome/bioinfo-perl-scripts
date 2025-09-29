#!/usr/bin/perl
open (FP,"$ARGV[0]");
if($ARGV[0] eq ''){print "Usage: perl get-com-trans.pl INPUTfile  OUTPUTfile\n";}
else{
open(OUT,">$ARGV[1]");
while ($linen = <FP>)
{
chomp $linen;
$line1 = $line2 = $line3 = $line4 = $line5 = "";
@linec = @line3 = ();
@split=split("##",$linen);
$line = $split[1];
print $line."\n";
$line1 =~ tr/RKEDQN/1/;	$line1 =~ tr/GASTPHY/2/;	$line1 =~ tr/CVLIMFW/3/;
@linec = split(//,$line1);
$line4 = join(",",@linec);
$line2 = $line1;

$co1 = $co2 = $co3 = $coo1 = $coo2 = $coo3 = $c1 = $c2 = $c3 = $c4 = $c5 = $c6 = $p1 = $p2 = $p3 = $p4 = $p5 = "";
$cop11 = $cop12 = $cop13 = $cop21 = $cop22 = $cop23 = $cop31 = $cop32 = $cop33 = $cop41 = $cop42 = $cop43 = $cop51 = $cop52 = $cop53 = "";


$co1 = ($line2 =~ tr/1/1/);	$co2 = ($line2 =~ tr/2/2/);	$co3 = ($line2 =~ tr/3/3/);
$coo1 = ($line2 =~ s/123/123/g);	$coo2 = ($line2 =~ s/231/231/g);	$coo3 = ($line2 =~ s/312/312/g);

if ($coo1 eq "") {$coo1 = "0";}	if ($coo2 eq "") {$coo2 = "0";}	if ($coo3 eq "") {$coo3 = "0";}
$c1 = ($line2 =~ s/11/11/g);	$c2 = ($line2 =~ s/13/13/g);	$c3 = ($line2 =~ s/21/21/g);	$c4 = ($line2 =~ s/22/22/g);	$c5 = ($line2 =~ s/32/32/g);	$c6 = ($line2 =~ s/33/33/g);
if ($c1 eq "") {$c1 = "0";}	if ($c2 eq "") {$c2 = "0";}	if ($c3 eq "") {$c3 = "0";}	if ($c4 eq "") {$c4 = "0";}	if ($c5 eq "") {$c5 = "0";}	if ($c6 eq "") {$c6 = "0";}

@line3 = split(//,$line);
$getsize=$#line3;
for ($i=0;$i<($getsize*(1/8));$i++) {
$p1 .= $line3[$i];
}
print ($getsize*(1/8));print "\t";
for ($i=($getsize*(1/8));$i<($getsize*(1/4));$i++) {
$p2 .= $line3[$i];
}
print ($getsize*(1/4));print "\t";
for ($i=$getsize*(1/4);$i<($getsize*(1/2));$i++) {
$p3 .= $line3[$i];
}
print ($getsize*(1/2));print "\t";
for ($i=$getsize*(1/2);$i<($getsize*(1/1.5));$i++) {
$p4 .= $line3[$i];
}
print ($getsize*(1/1.5));print "\t";
for ($i=$getsize*(1/1.5);$i<($getsize);$i++) {
$p5 .= $line3[$i];
}
print ($getsize);print "\t";
print "$p1\t$p2\t$p3\t$p4\t$p5\n";

$p1 =~ tr/RKEDQN/1/;	$p1 =~ tr/GASTPHY/2/;	$p1 =~ tr/CVLIMFW/3/;
$p2 =~ tr/RKEDQN/1/;	$p2 =~ tr/GASTPHY/2/;	$p2 =~ tr/CVLIMFW/3/;
$p3 =~ tr/RKEDQN/1/;	$p3 =~ tr/GASTPHY/2/;	$p3 =~ tr/CVLIMFW/3/;
$p4 =~ tr/RKEDQN/1/;	$p4 =~ tr/GASTPHY/2/;	$p4 =~ tr/CVLIMFW/3/;
$p5 =~ tr/RKEDQN/1/;	$p5 =~ tr/GASTPHY/2/;	$p5 =~ tr/CVLIMFW/3/;
$cop11 = ($p1 =~ tr/1/1/);	$cop12 = ($p1 =~ tr/2/2/);	$cop13 = ($p1 =~ tr/3/3/);
$cop21 = ($p2 =~ tr/1/1/);	$cop22 = ($p2 =~ tr/2/2/);	$cop23 = ($p2 =~ tr/3/3/);
$cop31 = ($p3 =~ tr/1/1/);	$cop32 = ($p3 =~ tr/2/2/);	$cop33 = ($p3 =~ tr/3/3/);
$cop41 = ($p4 =~ tr/1/1/);	$cop42 = ($p4 =~ tr/2/2/);	$cop43 = ($p4 =~ tr/3/3/);
$cop51 = ($p5 =~ tr/1/1/);	$cop52 = ($p5 =~ tr/2/2/);	$cop53 = ($p5 =~ tr/3/3/);
print "$cop11,$cop12,$cop13,$cop21,$cop22,$cop23,$cop31,$cop32,$cop33,$cop41,$cop42,$cop43,$cop51,$cop52,$cop53\n";
print OUT "$co1,$co2,$co3,$coo1,$coo2,$coo3,$c1,$c2,$c3,$c4,$c5,$c6,$cop11,$cop12,$cop13,$cop21,$cop22,$cop23,$cop31,$cop32,$cop33,$cop41,$cop42,$cop43,$cop51,$cop52,$cop53,";

#########################part-2#################################
$line1 = $line2 = $line3 = $line4 = $line5 = "";
$line1 = $line;
$line1 =~ tr/GASCTPD/1/;	$line1 =~ tr/NVEQIL/2/;	$line1=~ tr/MHKFRYW/3/;
@linec = split(//,$line1);
$line4 = join(",",@linec);
$line2 = $line1;	
$co1 = $co2 = $co3 = $coo1 = $coo2 = $coo3 = $c1 = $c2 = $c3 = $c4 = $c5 = $c6 = $p1 = $p2 = $p3 = $p4 = $p5 = "";
$cop11 = $cop12 = $cop13 = $cop21 = $cop22 = $cop23 = $cop31 = $cop32 = $cop33 = $cop41 = $cop42 = $cop43 = $cop51 = $cop52 = $cop53 = "";
$co1 = ($line2 =~ tr/1/1/);	$co2 = ($line2 =~ tr/2/2/);	$co3 = ($line2 =~ tr/3/3/);
$coo1 = ($line2 =~ s/123/123/g);	$coo2 = ($line2 =~ s/231/231/g);	$coo3 = ($line2 =~ s/312/312/g);
if ($coo1 eq "") {$coo1 = "0";}	if ($coo2 eq "") {$coo2 = "0";}	if ($coo3 eq "") {$coo3 = "0";}
$c1 = ($line2 =~ s/11/11/g);	$c2 = ($line2 =~ s/13/13/g);	$c3 = ($line2 =~ s/21/21/g);	$c4 = ($line2 =~ s/22/22/g);	$c5 = ($line2 =~ s/32/32/g);	$c6 = ($line2 =~ s/33/33/g);
if ($c1 eq "") {$c1 = "0";}	if ($c2 eq "") {$c2 = "0";}	if ($c3 eq "") {$c3 = "0";}	if ($c4 eq "") {$c4 = "0";}	if ($c5 eq "") {$c5 = "0";}	if ($c6 eq "") {$c6 = "0";}

@line3 = split(//,$line);
$getsize=$#line3;
for ($i=0;$i<($getsize*(1/8));$i++) {
$p1 .= $line3[$i];
}
for ($i=($getsize*(1/8));$i<($getsize*(1/4));$i++) {
$p2 .= $line3[$i];
}
for ($i=$getsize*(1/4);$i<($getsize*(1/2));$i++) {
$p3 .= $line3[$i];
}
for ($i=$getsize*(1/2);$i<($getsize*(1/1.5));$i++) {
$p4 .= $line3[$i];
}
for ($i=$getsize*(1/1.5);$i<($getsize);$i++) {
$p5 .= $line3[$i];
}

$p1 =~ tr/GASCTPD/1/;	$p1 =~ tr/NVEQIL/2/;	$p1 =~ tr/MHKFRYW/3/;
$p2 =~ tr/GASCTPD/1/;	$p2 =~ tr/NVEQIL/2/;	$p2 =~ tr/MHKFRYW/3/;
$p3 =~ tr/GASCTPD/1/;	$p3 =~ tr/NVEQIL/2/;	$p3 =~ tr/MHKFRYW/3/;
$p4 =~ tr/GASCTPD/1/;	$p4 =~ tr/NVEQIL/2/;	$p4 =~ tr/MHKFRYW/3/;
$p5 =~ tr/GASCTPD/1/;	$p5 =~ tr/NVEQIL/2/;	$p5 =~ tr/MHKFRYW/3/;
$cop11 = ($p1 =~ tr/1/1/);	$cop12 = ($p1 =~ tr/2/2/);	$cop13 = ($p1 =~ tr/3/3/);
$cop21 = ($p2 =~ tr/1/1/);	$cop22 = ($p2 =~ tr/2/2/);	$cop23 = ($p2 =~ tr/3/3/);
$cop31 = ($p3 =~ tr/1/1/);	$cop32 = ($p3 =~ tr/2/2/);	$cop33 = ($p3 =~ tr/3/3/);
$cop41 = ($p4 =~ tr/1/1/);	$cop42 = ($p4 =~ tr/2/2/);	$cop43 = ($p4 =~ tr/3/3/);
$cop51 = ($p5 =~ tr/1/1/);	$cop52 = ($p5 =~ tr/2/2/);	$cop53 = ($p5 =~ tr/3/3/);

#print "$cop11\t$cop12\t$cop13\t$cop21\t$cop22\t$cop23\t$cop31\t$cop32\t$cop33\t$cop41\t$cop42\t$cop43\t$cop51\t$cop52\t$cop53\n";
print OUT "$co1,$co2,$co3,$coo1,$coo2,$coo3,$c1,$c2,$c3,$c4,$c5,$c6,$cop11,$cop12,$cop13,$cop21,$cop22,$cop23,$cop31,$cop32,$cop33,$cop41,$cop42,$cop43,$cop51,$cop52,$cop53,";

#########################part-3#################################
$line1 = $line2 = $line3 = $line4 = $line5 = "";
$line1 = $line;
$line1 =~ tr/LIFWCMVY/1/;	$line1 =~ tr/PATGS/2/;	$line1=~ tr/HQRKNED/3/;
@linec = split(//,$line1);
$line4 = join(",",@linec);
$line2 = $line1;	
$co1 = $co2 = $co3 = $coo1 = $coo2 = $coo3 = $c1 = $c2 = $c3 = $c4 = $c5 = $c6 = $p1 = $p2 = $p3 = $p4 = $p5 = "";
$cop11 = $cop12 = $cop13 = $cop21 = $cop22 = $cop23 = $cop31 = $cop32 = $cop33 = $cop41 = $cop42 = $cop43 = $cop51 = $cop52 = $cop53 = "";
$co1 = ($line2 =~ tr/1/1/);	$co2 = ($line2 =~ tr/2/2/);	$co3 = ($line2 =~ tr/3/3/);
$coo1 = ($line2 =~ s/123/123/g);	$coo2 = ($line2 =~ s/231/231/g);	$coo3 = ($line2 =~ s/312/312/g);
if ($coo1 eq "") {$coo1 = "0";}	if ($coo2 eq "") {$coo2 = "0";}	if ($coo3 eq "") {$coo3 = "0";}
$c1 = ($line2 =~ s/11/11/g);	$c2 = ($line2 =~ s/13/13/g);	$c3 = ($line2 =~ s/21/21/g);	$c4 = ($line2 =~ s/22/22/g);	$c5 = ($line2 =~ s/32/32/g);	$c6 = ($line2 =~ s/33/33/g);
if ($c1 eq "") {$c1 = "0";}	if ($c2 eq "") {$c2 = "0";}	if ($c3 eq "") {$c3 = "0";}	if ($c4 eq "") {$c4 = "0";}	if ($c5 eq "") {$c5 = "0";}	if ($c6 eq "") {$c6 = "0";}


@line3 = split(//,$line);
$getsize=$#line3;
for ($i=0;$i<($getsize*(1/8));$i++) {
$p1 .= $line3[$i];
}
for ($i=($getsize*(1/8));$i<($getsize*(1/4));$i++) {
$p2 .= $line3[$i];
}
for ($i=$getsize*(1/4);$i<($getsize*(1/2));$i++) {
$p3 .= $line3[$i];
}
for ($i=$getsize*(1/2);$i<($getsize*(1/1.5));$i++) {
$p4 .= $line3[$i];
}
for ($i=$getsize*(1/1.5);$i<($getsize);$i++) {
$p5 .= $line3[$i];
}

$p1 =~ tr/LIFWCMVY/1/;	$p1 =~ tr/PATGS/2/;	$p1 =~ tr/HQRKNED/3/;
$p2 =~ tr/LIFWCMVY/1/;	$p2 =~ tr/PATGS/2/;	$p2 =~ tr/HQRKNED/3/;
$p3 =~ tr/LIFWCMVY/1/;	$p3 =~ tr/PATGS/2/;	$p3 =~ tr/HQRKNED/3/;
$p4 =~ tr/LIFWCMVY/1/;	$p4 =~ tr/PATGS/2/;	$p4 =~ tr/HQRKNED/3/;
$p5 =~ tr/LIFWCMVY/1/;	$p5 =~ tr/PATGS/2/;	$p5 =~ tr/HQRKNED/3/;
$cop11 = ($p1 =~ tr/1/1/);	$cop12 = ($p1 =~ tr/2/2/);	$cop13 = ($p1 =~ tr/3/3/);
$cop21 = ($p2 =~ tr/1/1/);	$cop22 = ($p2 =~ tr/2/2/);	$cop23 = ($p2 =~ tr/3/3/);
$cop31 = ($p3 =~ tr/1/1/);	$cop32 = ($p3 =~ tr/2/2/);	$cop33 = ($p3 =~ tr/3/3/);
$cop41 = ($p4 =~ tr/1/1/);	$cop42 = ($p4 =~ tr/2/2/);	$cop43 = ($p4 =~ tr/3/3/);
$cop51 = ($p5 =~ tr/1/1/);	$cop52 = ($p5 =~ tr/2/2/);	$cop53 = ($p5 =~ tr/3/3/);

#print "$cop11\t$cop12\t$cop13\t$cop21\t$cop22\t$cop23\t$cop31\t$cop32\t$cop33\t$cop41\t$cop42\t$cop43\t$cop51\t$cop52\t$cop53\n";
print OUT "$co1,$co2,$co3,$coo1,$coo2,$coo3,$c1,$c2,$c3,$c4,$c5,$c6,$cop11,$cop12,$cop13,$cop21,$cop22,$cop23,$cop31,$cop32,$cop33,$cop41,$cop42,$cop43,$cop51,$cop52,$cop53,";

#########################part-4#################################
$line1 = $line2 = $line3 = $line4 = $line5 = "";
$line1 = $line;
$line1 =~ tr/GASDT/1/;	$line1 =~ tr/CPNVEQIL/2/;	$line1=~ tr/KMHFRYW/3/;
@linec = split(//,$line1);
$line4 = join(",",@linec);
$line2 = $line1;	
$co1 = $co2 = $co3 = $coo1 = $coo2 = $coo3 = $c1 = $c2 = $c3 = $c4 = $c5 = $c6 = $p1 = $p2 = $p3 = $p4 = $p5 = "";
$cop11 = $cop12 = $cop13 = $cop21 = $cop22 = $cop23 = $cop31 = $cop32 = $cop33 = $cop41 = $cop42 = $cop43 = $cop51 = $cop52 = $cop53 = "";
$co1 = ($line2 =~ tr/1/1/);	$co2 = ($line2 =~ tr/2/2/);	$co3 = ($line2 =~ tr/3/3/);
$coo1 = ($line2 =~ s/123/123/g);	$coo2 = ($line2 =~ s/231/231/g);	$coo3 = ($line2 =~ s/312/312/g);
if ($coo1 eq "") {$coo1 = "0";}	if ($coo2 eq "") {$coo2 = "0";}	if ($coo3 eq "") {$coo3 = "0";}
$c1 = ($line2 =~ s/11/11/g);	$c2 = ($line2 =~ s/13/13/g);	$c3 = ($line2 =~ s/21/21/g);	$c4 = ($line2 =~ s/22/22/g);	$c5 = ($line2 =~ s/32/32/g);	$c6 = ($line2 =~ s/33/33/g);
if ($c1 eq "") {$c1 = "0";}	if ($c2 eq "") {$c2 = "0";}	if ($c3 eq "") {$c3 = "0";}	if ($c4 eq "") {$c4 = "0";}	if ($c5 eq "") {$c5 = "0";}	if ($c6 eq "") {$c6 = "0";}



@line3 = split(//,$line);
$getsize=$#line3;
for ($i=0;$i<($getsize*(1/8));$i++) {
$p1 .= $line3[$i];
}
for ($i=($getsize*(1/8));$i<($getsize*(1/4));$i++) {
$p2 .= $line3[$i];
}
for ($i=$getsize*(1/4);$i<($getsize*(1/2));$i++) {
$p3 .= $line3[$i];
}
for ($i=$getsize*(1/2);$i<($getsize*(1/1.5));$i++) {
$p4 .= $line3[$i];
}
for ($i=$getsize*(1/1.5);$i<($getsize);$i++) {
$p5 .= $line3[$i];
}
$p1 =~ tr/GASDT/1/;	$p1 =~ tr/CPNVEQIL/2/;	$p1 =~ tr/KMHFRYW/3/;
$p2 =~ tr/GASDT/1/;	$p2 =~ tr/CPNVEQIL/2/;	$p2 =~ tr/KMHFRYW/3/;
$p3 =~ tr/GASDT/1/;	$p3 =~ tr/CPNVEQIL/2/;	$p3 =~ tr/KMHFRYW/3/;
$p4 =~ tr/GASDT/1/;	$p4 =~ tr/CPNVEQIL/2/;	$p4 =~ tr/KMHFRYW/3/;
$p5 =~ tr/GASDT/1/;	$p5 =~ tr/CPNVEQIL/2/;	$p5 =~ tr/KMHFRYW/3/;
$cop11 = ($p1 =~ tr/1/1/);	$cop12 = ($p1 =~ tr/2/2/);	$cop13 = ($p1 =~ tr/3/3/);
$cop21 = ($p2 =~ tr/1/1/);	$cop22 = ($p2 =~ tr/2/2/);	$cop23 = ($p2 =~ tr/3/3/);
$cop31 = ($p3 =~ tr/1/1/);	$cop32 = ($p3 =~ tr/2/2/);	$cop33 = ($p3 =~ tr/3/3/);
$cop41 = ($p4 =~ tr/1/1/);	$cop42 = ($p4 =~ tr/2/2/);	$cop43 = ($p4 =~ tr/3/3/);
$cop51 = ($p5 =~ tr/1/1/);	$cop52 = ($p5 =~ tr/2/2/);	$cop53 = ($p5 =~ tr/3/3/);

#print "$cop11\t$cop12\t$cop13\t$cop21\t$cop22\t$cop23\t$cop31\t$cop32\t$cop33\t$cop41\t$cop42\t$cop43\t$cop51\t$cop52\t$cop53\n";
print OUT "$co1,$co2,$co3,$coo1,$coo2,$coo3,$c1,$c2,$c3,$c4,$c5,$c6,$cop11,$cop12,$cop13,$cop21,$cop22,$cop23,$cop31,$cop32,$cop33,$cop41,$cop42,$cop43,$cop51,$cop52,$cop53\n";


}
}

sub fraction{
my($line)=@_;
chomp($line);
undef @line3;undef $getsize;undef $p1;undef$p2;undef $p3;undef $p4;undef $p5;
@line3 = split(//,$line);
$getsize=$#line3;
for ($i=0;$i<printf("%d",$getsize*(1/8));$i++) {$p1 .= $line3[$i];}
for ($i=printf("%d",$getsize*(1/8));$i<((printf("%d",$getsize*(1/8)))$getsize*(1/4));$i++) {$p2 .= $line3[$i];}

for ($i=printf("%d",$getsize*(1/4));$i<($getsize*(1/2));$i++) {$p3 .= $line3[$i];}
for ($i=$getsize*(1/2);$i<($getsize*(1/1.5));$i++) {$p4 .= $line3[$i];}
for ($i=$getsize*(1/1.5);$i<($getsize);$i++) {$p5 .= $line3[$i];}
}
