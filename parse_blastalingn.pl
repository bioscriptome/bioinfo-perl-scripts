#Query= pos1@_0.46
#>pos1@_0.46
#ctaatatgttaattgatttat	1-21
#ctaatatgttaattgatttat	1-21
if($ARGV[0] eq ''){print 'program to parse the blastalgin program output '."\n".
'Usage: program_name input_blastalignoutput eff_seq_file.fasta  outputFile'."\n";}
    $inputFile=$ARGV[0];	### Input Sequence file for blast (multi-fasta file)
    $eff_seq=$ARGV[1];
    $result  =$ARGV[2];
open(FH,"$ARGV[0]");
open(FH1,"$ARGV[1]");
open(FA,">$ARGV[2]");
@baoutput=<FH>;close FH;
$baoutput=join("",@baoutput);
@baoutsingle=split("#@#",$baoutput);
@eff_seq=<FH1>;close FH1;
foreach $bao(@baoutsingle){#print $bao."\n";
		if($bao=~/Query= (pos\d+\@_\d+.\d+)/){print "---".$1."---\n";
			$id=$1;#print $bao;
			@singleseq=split("##",$bao);
			foreach $ss(@singleseq){
                               if($ss=~/$id/){@split=split("\n",$ss);$split[1]=~s/[\d\s-]//g;print  $split[1]."\n";}
                               # print $id."\n";
				if($ss!=~/$id/){@split=split("\n",$ss);$line2=$split[2];$line1=$split[1];}
				if($ss!=~/$id/){
					if($ss=~/>(pos[0-9\@_\.]+)/){$uid=$1;
						foreach $eff_seq(@eff_seq){
				                        if($eff_seq=~/$uid/){
								$line2=~/(\d+-\d+)/;
								$se=$1;
								$line1=~/(\d+-\d+)/;
								$se1=$1;
							       @se1=split('-',$se1);
							       @se2=split('-',$se);
$sems=$se1[0]-$se2[0];
$sems=~s/-//g;
print $sems."\t";print $se1[0]."\t".$se1[1]."\t";
#$XXs='-' x $sems;
$sem=$se1[0]-1;

if($se2[0] gt $se1[0]){$dot=21-$sems;
$for='=' x $dot;
print $for."\t";
#$sems=$se[0]-$se1[0];
$sems=~s/-//g;
#$XXs='X' x $sems;

}else{$dot=21;
$for='=' x $dot;
print $for."\t";
#$sems=$se[0]-$se1[0];
$sems=~s/-//g;
$XXs='=' x $sems;

}
							       print $se2[0]."\t".$se2[1]."\t";
                                      				@effseq=split("##",$eff_seq);
								print $uid."\t".$for." ".$XXs.$effseq[1];
							}
     						}
					}
					#print $ss;
				}
				#print $ss."\n";
			}
		}

}

