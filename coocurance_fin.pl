#!/usr/bin/perl 
use Getopt::Std;
getopts('i:o:n:');
$file1=$opt_i;
$file2=$opt_o;
$num=$opt_n;
open(OUT,">$file2");
$aa = "ACDEFGHIKLMNPQRSTVWYX";
@array=split("",$aa);
if (($opt_i ne '')&&($opt_o ne '')){
    open(FP1,"$file1");
    open(FP2,">$file2");
    #print FP2 "#AA , AC , AD , AE , AF , AG , AH , AI , AK , AL , AM , AN , AP , AQ , AR , AS , AT , AV , AW , AY , CA , CC , CD , CE , CF , CG , CH , CI , CK , CL , CM , CN , CP , CQ , CR , CS , CT , CV , CW , CY , DA , DC , DD , DE , DF , DG , DH , DI , DK , DL , DM , DN , DP , DQ , DR , DS , DT , DV , DW , DY , EA , EC , ED , EE , EF , EG , EH , EI , EK , EL , EM , EN , EP , EQ , ER , ES , ET , EV , EW , EY , FA , FC , FD , FE , FF , FG , FH , FI , FK , FL , FM , FN , FP , FQ , FR , FS , FT , FV , FW , FY , GA , GC , GD , GE , GF , GG , GH , GI , GK , GL , GM , GN , GP , GQ , GR , GS , GT , GV , GW , GY , HA , HC , HD , HE , HF , HG , HH , HI , HK , HL , HM , HN , HP , HQ , HR , HS , HT , HV , HW , HY , IA , IC , ID , IE , IF , IG , IH , II , IK , IL , IM , IN , IP , IQ , IR , IS , IT , IV , IW , IY , KA , KC , KD , KE , KF , KG , KH , KI , KK , KL , KM , KN , KP , KQ , KR , KS , KT , KV , KW , KY , LA , LC , LD , LE , LF , LG , LH , LI , LK , LL , LM , LN , LP , LQ , LR , LS , LT , LV , LW , LY , MA , MC , MD , ME , MF , MG , MH , MI , MK , ML , MM , MN , MP , MQ , MR , MS , MT , MV , MW , MY , NA , NC , ND , NE , NF , NG , NH , NI , NK , NL , NM , NN , NP , NQ , NR , NS , NT , NV , NW , NY , PA , PC , PD , PE , PF , PG , PH , PI , PK , PL , PM , PN , PP , PQ , PR , PS , PT , PV , PW , PY , QA , QC , QD , QE , QF , QG , QH , QI , QK , QL , QM , QN , QP , QQ , QR , QS , QT , QV , QW , QY , RA , RC , RD , RE , RF , RG , RH , RI , RK , RL , RM , RN , RP , RQ , RR , RS , RT , RV , RW , RY , SA , SC , SD , SE , SF , SG , SH , SI , SK , SL , SM , SN , SP , SQ , SR , SS , ST , SV , SW , SY , TA , TC , TD , TE , TF , TG , TH , TI , TK , TL , TM , TN , TP , TQ , TR , TS , TT , TV , TW , TY , VA , VC , VD , VE , VF , VG , VH , VI , VK , VL , VM , VN , VP , VQ , VR , VS , VT , VV , VW , VY , WA , WC , WD , WE , WF , WG , WH , WI , WK , WL , WM , WN , WP , WQ , WR , WS , WT , WV , WW , WY , YA , YC , YD , YE , YF , YG , YH , YI , YK , YL , YM , YN , YP , YQ , YR , YS , YT , YV , YW , YY\n";
	while($t1=<FP1>){
	chomp($t1);uc($t1);$c1 = substr($t1,0,1);
	if($c1 =~ ">")
	{   @parts= split("##",$t1);
	    $pep=$parts[1];
	    for($i1=1; $i1 <= 20; $i1++){for($i2=1; $i2 <= 20; $i2++){$comp[$i1][$i2]=0;}}
	    foreach $first(@array){
	      foreach $second(@array){
              print "$first$second,";
	      $pep1=$pep;
	      if($pep1=~/.*($first.{0,$num}.$second).*/){print OUT "1,";print $1."\t*$first.{$num}.$second.*\n";}else{print OUT "0,";print "0,"}
#	      if($pep1=~/.*($first.{0,$num}.$second).*/){print $1."\t*$first.{$num}.$second.*\n";}else{print "0,"}	      
	      }	print  "\n";      
	    }print OUT "\n";
	    $count=0;
	}
    }
    close FP1;
    close FP2;
}
if (($opt_i eq '')&&($opt_o eq ''))
{
    print "USAGE: pro2nac -i <input file> -o <outfput file> -n <number of inbetween residues>\n";
    print "Input sequence in single fasta format\n";
    exit();
}
