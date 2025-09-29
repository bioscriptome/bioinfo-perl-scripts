#!/usr/bin/perl

## usage: program positiveColFile negativeColFile vector_size outMatFile
open (POS,"$ARGV[0]");
@pos=@neg=@aap=();
open (NEG,"$ARGV[1]");
$vector=$ARGV[2]; chomp $vector;
open (OUT,">$ARGV[3]");

$amino="A,C,D,E,F,G,H,I,K,L,M,N,P,Q,R,S,T,V,W,Y"; 
@amino=split",",$amino;

$dipep="AA,AC,AD,AE,AF,AG,AH,AI,AK,AL,AM,AN,AP,AQ,AR,AS,AT,AV,AW,AY,CA,CC,CD,CE,CF,CG,CH,CI,CK,CL,CM,CN,CP,CQ,CR,CS,CT,CV,CW,CY,DA,DC,DD,DE,DF,DG,DH,DI,DK,DL,DM,DN,DP,DQ,DR,DS,DT,DV,DW,DY,EA,EC,ED,EE,EF,EG,EH,EI,EK,EL,EM,EN,EP,EQ,ER,ES,ET,EV,EW,EY,FA,FC,FD,FE,FF,FG,FH,FI,FK,FL,FM,FN,FP,FQ,FR,FS,FT,FV,FW,FY,GA,GC,GD,GE,GF,GG,GH,GI,GK,GL,GM,GN,GP,GQ,GR,GS,GT,GV,GW,GY,HA,HC,HD,HE,HF,HG,HH,HI,HK,HL,HM,HN,HP,HQ,HR,HS,HT,HV,HW,HY,IA,IC,ID,IE,IF,IG,IH,II,IK,IL,IM,IN,IP,IQ,IR,IS,IT,IV,IW,IY,KA,KC,KD,KE,KF,KG,KH,KI,KK,KL,KM,KN,KP,KQ,KR,KS,KT,KV,KW,KY,LA,LC,LD,LE,LF,LG,LH,LI,LK,LL,LM,LN,LP,LQ,LR,LS,LT,LV,LW,LY,MA,MC,MD,ME,MF,MG,MH,MI,MK,ML,MM,MN,MP,MQ,MR,MS,MT,MV,MW,MY,NA,NC,ND,NE,NF,NG,NH,NI,NK,NL,NM,NN,NP,NQ,NR,NS,NT,NV,NW,NY,PA,PC,PD,PE,PF,PG,PH,PI,PK,PL,PM,PN,PP,PQ,PR,PS,PT,PV,PW,PY,QA,QC,QD,QE,QF,QG,QH,QI,QK,QL,QM,QN,QP,QQ,QR,QS,QT,QV,QW,QY,RA,RC,RD,RE,RF,RG,RH,RI,RK,RL,RM,RN,RP,RQ,RR,RS,RT,RV,RW,RY,SA,SC,SD,SE,SF,SG,SH,SI,SK,SL,SM,SN,SP,SQ,SR,SS,ST,SV,SW,SY,TA,TC,TD,TE,TF,TG,TH,TI,TK,TL,TM,TN,TP,TQ,TR,TS,TT,TV,TW,TY,VA,VC,VD,VE,VF,VG,VH,VI,VK,VL,VM,VN,VP,VQ,VR,VS,VT,VV,VW,VY,WA,WC,WD,WE,WF,WG,WH,WI,WK,WL,WM,WN,WP,WQ,WR,WS,WT,WV,WW,WY,YA,YC,YD,YE,YF,YG,YH,YI,YK,YL,YM,YN,YP,YQ,YR,YS,YT,YV,YW,YY";
@dipep=split",",$dipep;

if ($vector==20) { @amino=@amino; }
if ($vector==400) { @amino=@dipep; }

$c=1;
while ($line=<POS>)
{
if ($line !~ /#/)
 {
chomp $line;
@val=split",",$line;
for ($x=0;$x<$vector;$x++)
	{
	$pos[$x]+=$val[$x];
	}
$c++;
 }
}

$c2=1;
while ($line2=<NEG>)
{
if ($line2 !~ /#/)
 {
chomp $line2;
@val2=split",",$line2;
for ($y=0;$y<$vector;$y++)
        {
        $neg[$y]+=$val2[$y];
        }
$c2++;
 }
}
close POS;
close NEG;

for ($z=0;$z<$vector;$z++)
        {
	$pos[$z]=$pos[$z]/$c;
        $neg[$z]=$neg[$z]/$c2;
	if (($pos[$z] == 0) || ($neg[$z] == 0)) 	{ $aap[$z]=0;           	   		}
	else 						{ $aap[$z]=log($pos[$z]/$neg[$z])/log(10); 	}
	}

####  finding minimum and maxima of @aap
@aap2=sort { $a <=> $b } @aap; 
$min=$aap2[0]; $max=$aap2[-1];
#print "\nMIN=$min\tMAX=$max\n";

#$aap=join",",@aap;
#print "AAP1\n$aap\n";

## Normalizing matrix values

for ($r=0;$r<$vector;$r++)
        {
	$aap[$r]=(2*(($aap[$r]-$min)/($max-$min)))-1; print OUT "$amino[$r]\t$aap[$r]\n";
	}

close OUT;
