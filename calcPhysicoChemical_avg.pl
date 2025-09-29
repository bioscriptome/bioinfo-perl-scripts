#!/usr/bin/perl


if($ARGV[0] eq ''){print ' Program for calculating PhysicoChemical property values (values/addition values) for each amino acid in a pattern file; 
## usage: program physicoMatrixFile PeptideFile  > outputFile
';}
else{
@amino=qw('#' A C D E F G H I K L M N P Q R S T V W Y X);
$aa = "#ACDEFGHIKLMNPQRSTVWYX";
$physicoFile=$ARGV[0];
$pepFile=$ARGV[1];  ## motif file without header
$null='0.00, 'x$property;
open (PEPFILE,"$pepFile");
@pep=();
@pep=<PEPFILE>;
foreach $t1(@pep){
        chomp($t1);
        uc($t1);
       undef %hash,@comp,@ti,@ti1;
        $c1 = substr($t1,0,1);
        if($c1 =~ ">")
        {
            @ti = split("##",$t1);
            @ti1 = split("",$ti[1]);
            $len = length ($ti[1]);
            $len1 = $#ti1;
            for($i1=1; $i1 <= 21; $i1++){$comp[$i1]=0;}
            foreach(@ti1){
                $c2 = $_;
                $in1 = index($aa,$c2);
                $comp[$in1]++;
            }
            for($i1=1; $i1 <= 21; $i1++){
                $perc =$comp[$i1];
                if($i1 <= 21)
                {
                   $hash{$amino[$i1]}=$perc;
                }
            }

        }

    



#foreach $res(@amino) 
 # {   
 $count=0;
 $val=0;
 open (PHYSICOFILE,"$physicoFile");
 while ($line=<PHYSICOFILE>)
    {
   chomp $line;
######################   if ($line !~ /#/)  ## Ignoring comment line
   if (($line !~ /#/) ||($line !~ />/))  ## Ignoring comment line                                                                                  
     {
      undef @mat,$add_pro,@split;
      @mat=();
      @split=split("\t",$line);
      $add_pro=$hash{$split[0]}*$split[1];
     # print "$hash{$split[0]}=>$split[1]=>$add_pro,";
      if($split[0] eq 'X'){print "$add_pro"; }
      else{print "$add_pro,";}
    }
    }
  close PHYSICOFILE;
  if ($count == 0) {print "$null";}
  #}
print "\n";
 


}}
close PEPFILE;
