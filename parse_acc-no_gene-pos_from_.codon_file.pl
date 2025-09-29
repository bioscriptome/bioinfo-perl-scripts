
use  LWP::Simple;
open(FA,">$ARGV[0].acc_num_pos");
open(FA1,">$ARGV[0].acc_num");
open(codon,$ARGV[0]);#codon usage database *.codon file
@codon_file=<codon>;close FH;
$str='(';
foreach $cod_line21(@codon_file){
		#if($cod_line=~/^>[a-zA-z0-9.]+[#]?[0-9]+\\[a-zA-z0-9.]+\\(.+)\\[0-9]+\\[A-Za-z0-9.]+
		#if($cod_line=~/^>[a-zA-z0-9.]+[#]?[0-9]+\\[a-zA-z0-9.]+\\(.+)\\[0-9]+\\[a-zA-Z0-9.]+\\[0-9a-zA-Z.]\\.+\/product="(.+)"\/(protein_id=".+"\/.+/){
				#if($cod_line=~/^>([a-zA-Z0-9.]+)#*.+\\(\d+\.\.\d+)/){	print FA $1."\t$2\n";				}if($cod_line=~/^>([a-zA-Z0-9.]+).+\\((join|complement)\([\d\.,\s.]+\))/){print FA $1."\t$2\n";}

if($cod_line21=~/^>/){
$str="(".$str;
#print $str."\n";
$cod_line21=~s/\\/@/g;
@cod_lin=split('@',$cod_line21);
$cod_lin[0]=~s/#.+//g;
$cod_lin[0]=~s/>//g;
$str.="$cod_lin[0]\[Accession] ) or ";
print FA $cod_lin[0]."\t$cod_lin[2]\n";
print FA1 $cod_lin[0]."\n";
#print $cod_lin[0]."\t$cod_lin[2]\t$cod_lin[3]\t$cod_lin[5]\t$cod_lin[6]\n";
#getprint ('http://www.ncbi.nlm.nih.gov/nuccore/AY339441?report=fasta&log$=seqview&format=text');


}


}
#open(FAA,">$name.aac_num4ncbi");
#print FAA $str;

#close FA;
#open(FA,"$name.acc_num_pos");



