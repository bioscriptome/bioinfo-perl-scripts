use lib "/home/nishant/progs/sub";
use SUB;
use POSIX;
#use Mysql;


$GENOME=$ARGV[0];#genome file 
system "perl ~/gpsr_1.0/bin/fasta2sfasta_codon_pref -i $GENOME -o $GENOME.sfasta";
#open(GEN,">$GENOME.sfasta");
open(GEN,"$GENOME.sfasta");
#output file having codon and its positions
@genome=<GEN>;close GEN;
$genome="";
#$break=$ARGV[2];
system "[ -d files ] || mkdir files";
#open(ACC_ORG,">./files/$id.ACC_ORG");

foreach $line(@genome){chomp($line);
		($id,$genome)=split("##",$line);$id=~s/>//g;print $id;#$id=~s/\s//g;
$id=~s/\s//g;
print $id;
#@split=split('@',$id);
print $genome;

#$id=$split[0];
open(COD_POS,">./files/$id.c_l_p");
open(COD_POS_DB,">./files/$id.DB");
print $id;
	#		@codon=('TTT', 'TCT', 'TAT', 'TGT', 'TTC', 'TCC', 'TAC', 'TGC', 'TTA', 'TCA', 'TAA', 'TGA', 'TTG', 'TCG', 'TAG', 'TGG', 'CTT', 'CCT', 'CAT', 'CGT', 'CTC', 'CCC', 'CAC', 'CGC', 'CTA', 'CCA', 'CAA', 'CGA', 'CTG', 'CCG', 'CAG', 'CGG', 'ATT', 'ACT', 'AAT', 'AGT', 'ATC', 'ACC', 'AAC', 'AGC', 'ATA', 'ACA', 'AAA', 'AGA', 'ATG', 'ACG', 'AAG', 'AGG', 'GTT', 'GCT', 'GAT', 'GGT', 'GTC', 'GCC', 'GAC', 'GGC', 'GTA', 'GCA', 'GAA', 'GGA', 'GTG', 'GCG', 'GAG', 'GGG');
@codon=('ATT', 'ATC', 'ATA','CTT', 'CTC', 'CTA', 'CTG', 'TTA', 'TTG','GTT', 'GTC', 'GTA', 'GTG','TTT', 'TTC','ATG','TGT', 'TGC','GCT', 'GCC', 'GCA', 'GCG','GGT', 'GGC', 'GGA', 'GGG' ,'CCT', 'CCC', 'CCA','CCG','ACT', 'ACC', 'ACA', 'ACG','TCT','TCC', 'TCA', 'TCG', 'AGT', 'AGC','TAT','TAC','TGG','CAA', 'CAG','AAT', 'AAC','CAT', 'CAC','GAA', 'GAG','GAT', 'GAC','AAA', 'AAG','CGT', 'CGC', 'CGA', 'CGG', 'AGA', 'AGG','TAA', 'TAG', 'TGA');
			foreach $codon(@codon){chomp($codon);
			#@codon_pref="";
			undef @codon_pref;
			#print $codon;
			#print $genome."\n";
			$length=length($genome);
			if($genome=~/$codon/){
				@codon_pref=SUB::multi_index_add($genome,$codon,3);
			if(scalar(@codon_pref)!= 0){	print COD_POS "$codon##$length##";
			print COD_POS_DB "$codon,$length,";
				foreach$co(@codon_pref){
				#if($co>=3){$mod=$co%3;}
				#if($mod==1 ||$co==1){
				print COD_POS $co."\t";#}
				print COD_POS_DB $co."\t";#}
			}
				print COD_POS "\n";print COD_POS_DB "\n";}
				}
				else {
				print   "$codon not found\n";
				print  COD_POS_DB "$codon,$length,0\n";
				}
			}
			close COD_POS;
			close COD_POS_DB;






$first_co=$sec_co=$thr_co=$four_co=$five_co=$six_co=0;$tot_co=0;
open(FO,"./files/$id.c_l_p");
open(TEMP,">temp");
open(CP,">./files/$id.c_p");
@cod_len_pos=<FO>;close FO;
#print $length."\n";
print CP"Codon\tAA\t1w\t2w\t3w\t4w\t5w\t6w\ttot_cod\n";$num_co=0;
foreach $cod_len_pos(@cod_len_pos){
		chomp($cod_len_pos);chop($cod_len_pos);
		#print $cod_len_pos."\n";
$num_co++;
		if($cod_len_pos=~/##/){

				@co_le_pos=split("##",$cod_len_pos);
				@pos=split("\t",$co_le_pos[2]);
				#$add=$co_le_pos[1]/$ARGV[2];
				#print scalar(@pos)."\n";
				}else {print "\nnot found\n";}
				$add1=$co_le_pos[1]/6;
				$add=ceil($add1);if(scalar(@pos) ne 0){print TEMP $co_le_pos[0]."##";}
				$a_s=0;$b_s=$add;$c_s=2*$add;$d_s=3*$add;$e_s=4*$add;$f_s=5*$add;$first=$sec=$thr=$four=$five=$six=$tot=0;
				foreach $pos(@pos){
				#print $pos."  first\t";
				#	$mod=0;
				#	$mod=$pos%3;
				#if($mod==0){ print TEMP $pos."\t";
				 if($pos >= $a_s && $pos < $b_s ){$first++;$tot++;}		
				 if($pos >= $b_s && $pos < $c_s ){$sec++;$tot++;}		
				 if($pos >= $c_s && $pos < $d_s ){$thr++;$tot++;}		
				 if($pos >=$d_s && $pos < $e_s ){$four++;$tot++;}		
				 if($pos >= $e_s && $pos < $f_s ){$five++;$tot++;}		
				 if($pos >= $f_s && $pos < $co_le_pos[1]){$six++;$tot++;}		
									}
                                 $tot_per=($tot*100)/($co_le_pos[1]/3);
                                $aa=SUB::codon2aa($co_le_pos[0]);
				print CP "$co_le_pos[0]\t$aa";#printf "%d",$b_s;
				print CP "\t$first";#printf "%d",$c_s;
				print CP "\t$sec";#printf "%d",$d_s;
				print CP "\t$thr";#printf "%d",$e_s;
				print CP "\t$four";#printf "%d",$f_s;
				print CP "\t$five";#printf "%d",$co_le_pos[1];
				print CP "\t$six\t$tot\t";printf(CP "%4.2f ",$tot_per);print CP "\n";
				$tot_co+=$tot;
				$first_co+=$first;
				$sec_co+=$sec;
				$thr_co+=$thr;
				$four_co+=$four;
				$five_co+=$five;
				$six_co+=$six;
				
		
print TEMP "\n";
}
print  CP "$num_co\t\t$first_co\t$sec_co\t$thr_co\t$four_co\t$five_co\t$six_co\t$tot_co\n";
close CP;




open(FINAL,">./files/$id.cpt");
if(open(CPT,"./files/$id.c_p")){print "file opened";}
@CPT=<CPT>;
close CPT;
@aa=('I','L','V','F','M','C','A','G','P','T','S','Y','W','Q','N','H','E','D','K','R','Z');
foreach$aa(@aa){$vname = $aa;$$vname = 0;}
print "Codon\tAA\t1w\t2w\t3w\t4w\t5w\t6w\ttot_cod\tall_usg\tcod_usg\n";
foreach$cpt(@CPT){
		chomp($cpt);
        	if($cpt=~/[A-Z]{3}\t([A-Z])\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t(\d+).+/){foreach$aa(@aa){if($1 eq $aa){$vname = $aa;$$vname+=$2;}}}
		}

foreach$cpt(@CPT){
	chomp($cpt);
	if($cpt=~/([A-Z]{3}\t([A-Z])\t\d+\t\d+\t\d+\t\d+\t\d+\t\d+\t(\d+).+)/){
			$two=$2;
			$codon_usage=$3*100/$$two;
			print FINAL $1."\t";
			printf(FINAL "%4.2f ",$codon_usage);
			print FINAL"\n";
		}
	if($cpt=~/^\d+/){
print FINAL $cpt."\t\t\n";
		}
	}

}
__END__
$host = "localhost";
$database = "codon_preference";
$tablename = "codon_pref";
$user = "root";
$pw = "hivsirna";
$connect = Mysql->connect($host, $database, $user, $pw);
$connect->selectdb($database);
$myquery = "SELECT * FROM $tablename";
$execute = $connect->query($myquery);
$rownumber = $execute->numrows();
$fieldnumber = $execute->numfields();
print $rownumber."<br />";
print $fieldnumber."<br />";



#CREATE TABLE `codon_preference`.`codon_pref` (`codon` VARCHAR(100) NOT NULL, `aa` VARCHAR(10) NOT NULL, `w1` INT(100) NOT NULL, `w2` INT(100) NOT NULL, `w3` INT(100) NOT NULL, `w4` INT(100) NOT NULL, `w5` INT(100) NOT NULL, `w6` INT(100) NOT NULL, `total_codon` INT(100) NOT NULL, `overall_usage` INT(100) NOT NULL, `codon_usage` INT(100) NOT NULL) ENGINE = MyISAM;







__END__
for($i=0;$i<$ARGV[2];$i++){
						if(($pos gt $sum )&& ($pos lt ($sum+$add))){
                                                                #print "yes\n";
								#print "\$co_le_pos[0]=$co_le_pos[0]\t\$i=";
								#print $i."\t\$sum=$sum\t\$pos=$pos\t\$break[$i]\t\$sum1=";
							$vname = $co_le_pos[0];
							$$vname = "555-1234";
			print $phone;
								$break[$i]=$sum1++;
								#print $sum1."\n";
							next;
							}
						$sum=$sum+$add;#print "----$sum----\n"
				}
