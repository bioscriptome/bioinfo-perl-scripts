#~/usr/bin/perl -w
#usage perl program input_gff_format out_id_pos_file
open(FH,$ARGV[0]);
open(FA,">".$ARGV[1]);
$rem_psi=$ARGV[2];
#    A7A134UniProtKBModified residue289289...Note=Phosphoserine%3B by ATR and ATM;Status=By similarity
#    ##sequence-region B5VN01 1 761
$i=0;
if($rem_psi eq 'y'){ print "Removing probable similer..............................................................................................\n";
		     sleep(1);}   else {print "Keeping  probable similer..............................................................................................\n";sleep(1);}
while($seq=<FH>){chomp($seq);
		 if($seq=~/.+sequence-region\s+([A-Za-z0-9.]+).+/){
		     $id=$1;
		 }
		 if($rem_psi eq ''){
		     if($seq=~/^$id\t+UniProtKB\t+Modified residue\t+([0-9]+).+Note=(Phosphothreonine|Phosphoserine|Phosphotyrosine)/)
		     { $id[$i++]=$id;
			 print FA ">$id ##$1\n";
			 }
		 }
		 if($rem_psi eq 'y'){  if($seq=~/^$id\t+UniProtKB\t+Modified residue\t+([0-9]+).+Note=(Phosphothreonine|Phosphoserine|Phosphotyrosine)\t/)                 {
		     $id[$i++]=$id;
		     print FA ">$id ##$1\n";}
				       }
		 
	     }

close FA;
my %h;
@id1=grep { !$h{$_}++ } @id;
open(UNI,">unique");
foreach $id(@id1){print UNI $id."\n";}
system "perl ~/progs/phosphorylation_sites_with_id.pl $ARGV[1] unique $ARGV[1].single"; 
#system "rm unique";
