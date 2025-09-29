#!/usr/bin/perl


if($ARGV[0] eq ''){print ' Program for calculating PhysicoChemical property values (values/addition values) for each amino acid in a pattern file; change 34-35 line Accordingly
## usage: program physicoMatrixFile PeptideFile  > outputFile
';}
@amino=(A,R,N,D,C,Q,E,G,H,I,L,K,M,F,P,S,T,W,Y,V,X);

$physicoFile=$ARGV[0];
$pepFile=$ARGV[1];  ## motif file without header


$null='0.00, 'x$property;

#print "NULL:$null:\n";
open (PEPFILE,"$pepFile");
while ($linePep=<PEPFILE>)
{
chomp $linePep;
@pep=();
@split_line=split("##",$linePep);
@pep=split"",$split_line[1];
undef $add_val;
$count=0;
foreach $res(@pep) 
  {   
# $count=0;
 $val=0;
 open (PHYSICOFILE,"$physicoFile");
 while ($line=<PHYSICOFILE>)
    {
   chomp $line;
######################   if ($line !~ /#/)  ## Ignoring comment line
   if (($line !~ /#/) ||($line !~ />/))  ## Ignoring comment line                                                                                                             

     {
  @mat=();
if ($line =~ /$res/) { $count++; @mat=split"\t",$line;$add_val+=$mat[1]; } ## for multiple column matrix

##  if ($line =~ /$res/) { $count++; @mat=split"\t",$line; for ($x=1;$x<@mat;$x++) { $mat[$x]=~ s/\s+//; $val+=$mat[$x]; } print "$val, "; } ## Addition
     }
    }
  close PHYSICOFILE;
  if ($count == 0) {print "$null";}
  }
$prop_sum=$add_val/$count;

print "$prop_sum\n";
 


}
close PEPFILE;
