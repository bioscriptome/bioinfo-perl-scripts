#!/usr/bin/perl -w
#needs argv0=pos-fasta, argv1=neg-fasta, argv2=molecule.   ::: eg perl MASTER.pl AP AN IgA
use Getopt::Std;
#!/usr/bin/perl
getopts('p:n:v:m:f:');
    $lc_pos=$opt_p;#positive lower case sfasta
    $lc_neg=$opt_n;#negative lower case sfasta
    #$blind_pos=$opt_v;#blind positive lower case sfasta
    #$blind_neg=$opt_m;#blind negative lower case sfasta
    $fold=$opt_f;#folder name to save the output
    if($lc_pos eq ''|| $lc_neg eq ''){print '-p:positive lower case sfasta 
-n:negative lower case sfasta
-f:folder for prcessing data
'}else{
    if($folder eq ''){$folder='.';}else{$folder=$folder;}
    @windows=qw(7);
    $compute=0;
    foreach $win(@windows){
	$compute++;
	chdir($fold);
	$path="$fold/w$win";
	system "mkdir $path";
	chomp($win);
	system "perl ~/progs/lc_sfasta2mot_sfasta.pl $lc_pos $win $path/pos_input";
	print "perl ~/progs/lc_sfasta2mot_sfasta.pl $lc_pos $win $path/neg_input";
	system "mkdir $fold";
	system "mkdir $fold/aac";
	system "mkdir $fold/dpc";
	system "mkdir $fold/bin";
	system "mkdir $fold/physiochem";
	system "mkdir $fold/composition-transition";
	system "mkdir $fold/aminoacidpair";
	system "mkdir $fold/aminoacidpair/AAaac";
	system "mkdir $fold/aminoacidpair/AAdpc";
	

	system "perl fasta2sfasta -i $path/pos_input -o $fold/psfasta";
	system "perl pro2aac -i $fold/psfasta -o $fold/aac/posaac";
	system "perl fasta2sfasta -i $path/neg_input -o $fold/nsfasta";
	system "perl pro2aac -i $fold/nsfasta -o $fold/aac/negaac";
	system "cp ../autoprogs/* $fold/aac/ ";$aac="$fold/aac";
	system "perl $fold/aac/auto.pl $fold/aac/posaac $fold/aac/negaac aac $aac";
	
	
	system "perl pro2dpc -i $fold/psfasta -o $fold/dpc/posdpc";
	system "perl pro2dpc -i $fold/nsfasta -o $fold/dpc/negdpc";
	system "cp ../autoprogs/* $fold/dpc/ ";$dpc="$fold/dpc";
	system "perl $fold/dpc/auto.pl $fold/dpc/posdpc $fold/dpc/negdpc dpc $dpc";
	
	
	system "perl physicochemicalpro.pl $fold/psfasta $fold/physiochem/posphy";
	system "perl physicochemicalpro.pl $fold/nsfasta $fold/physiochem/negphy";
	system "cp ../autoprogs/* $fold/physiochem/ ";$physiochem="$fold/physiochem";
	system "perl $fold/physiochem/auto.pl $fold/physiochem/posphy $fold/physiochem/negphy phy $physiochem";
	
	
	system "perl composition-transition-get.pl $fold/psfasta > $fold/composition-transition/pget";
	system "perl composition-transition-get.pl $fold/nsfasta > $fold/composition-transition/nget";
	system "cp ../autoprogs/* $fold/composition-transition/ ";$composition="$fold/composition-transition";
	system "perl $fold/composition-transition/auto.pl $fold/composition-transition/pget $fold/composition-transition/nget get $composition";

	
	system "perl create_aapMatrix.pl $fold/aac/posaac $fold/aac/negaac 20 $fold/aminoacidpair/AAaac/_AAmatrix";
	system "perl calc_aap_multi.pl $fold/aac/posaac $fold/aminoacidpair/AAaac/_AAmatrix $fold/aminoacidpair/AAaac/_AApairaacpos";
	system "perl calc_aap_multi.pl $fold/aac/negaac $fold/aminoacidpair/AAaac/_AAmatrix $fold/aminoacidpair/AAaac/_AApairaacneg";
	system "cp ../autoprogs/* $fold/aminoacidpair/AAaac/ ";$AAaac="$fold/aminoacidpair/AAaac";
	system "perl $fold/aminoacidpair/AAaac/auto.pl $fold/aminoacidpair/AAaac/_AApairaacpos $fold/aminoacidpair/AAaac/_AApairaacneg AApairaac $AAaac";
	
	
	system "perl create_aapMatrix.pl $fold/dpc/posdpc $fold/dpc/negdpc 400 $fold/aminoacidpair/AAdpc/_AAmatrix";
	system "perl calc_aap_multi.pl $fold/dpc/posdpc $fold/aminoacidpair/AAdpc/_AAmatrix $fold/aminoacidpair/AAdpc/_AApairdpcpos";
	system "perl calc_aap_multi.pl $fold/dpc/negdpc $fold/aminoacidpair/AAdpc/_AAmatrix $fold/aminoacidpair/AAdpc/_AApairdpcneg";
	system "cp ../autoprogs/* $fold/aminoacidpair/AAdpc/ ";$AAdpc="$fold/aminoacidpair/AAdpc";
	system "perl $fold/aminoacidpair/AAdpc/auto.pl $fold/aminoacidpair/AAdpc/_AApairdpcpos $fold/aminoacidpair/AAdpc/_AApairdpcneg AApairdpc $AAdpc";
	
	
	system "perl motif2bin -i $path/pos_input -x n -o $fold/bin/posbin";
	system "perl motif2bin -i $path/neg_input -x n -o $fold/bin/negbin";
	system "cp ../autoprogs/* $fold/bin/ ";$bin="$fold/bin";
	system "perl $fold/bin/auto.pl $fold/bin/posbin $fold/bin/negbin bin $bin";
    }
}



