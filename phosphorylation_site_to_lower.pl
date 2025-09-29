#$seq='YCR088W	S156	T157	T165	S167	S169	T181	S183	S365	S389	S458	S475	S478	S481	malepidytthsreidaeylkivrgsdpdttwliispnakkeyepestgssfhdflqlfdetkvqyglarvsppgsdvekiiiigwcpdsaplktrasfaanfaavannlfkgyhvqvtardeddldenellmkisnaagarysiqtsskqqgkastppvkksftpskspapvskkepvktpspapaakissrvndnnddddwnepelkerdfdqaplkpnqssykpigkidlqkviaeekakedprlvqkptaagskidpssdianlknesklkrdsefnsflgttkppsmtesslkndddkvikgfrnekspaqlwaerkakqnsgnaetkaeapkpevpedepegepdvkdlkskfeglaasekeeeemenkfapppkkseptiispkpfskpqepvkaeeaeqpktdykkignplpgmhieadneeepeendddwdddedeaaqpplpsrnvasgapvqkeepeqeeiapslpsrnsipapkqeeapeqapeeeieeeaeeaapqlpsrssaappppprratpekkpkenpwataeydydaaedneltfvendkiiniefvdddwwlgelekdgskglfpsnyvslgn';
open(FH,"out_new1");
while($seq=<FH>){chomp($seq);
@array0=split("\t",$seq);chomp($array0[0]);chomp($array0[1]);chomp($array0[2]);$size=scalar(@array0);$seq1=uc($array0[$size-1]);#print $seq1."\n";
@seq=split("",$seq1);for($i=1;$i<$size-2;$i++){
                                 @site=split("",$array0[$i]);#print @site;
                                 $pos=$array0[$i];print $pos;
                                 $residue=$site[0];
                                 $residue=lc($residue);
                                 $pos=~s/[A-Z]//g;print $pos;
     #                            $substri
                                 @seq=@seq;
				splice(@seq,$pos-1,1,$residue);
				#print @seq;

}#print $seq1;
print @seq."\n";}
