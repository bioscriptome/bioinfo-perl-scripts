open(FH,$ARGV[0]);#file having multiple line with same id
open(FH1,$ARGV[1]);#file having unique id;
open(FA,'>'.$ARGV[2]);#out_file having id_seq;
open(FA1,'>'.$ARGV[3]);#outfile_having_id_pos
@id=<FH1>;
@seq=<FH>;
close FH1,FH;$count=0;$line=0;
foreach $id(@id){
chomp($id);
$i=0;
print FA"\n>".$id."##";
print FA1 "\n>".$id."##";
  foreach $seq(@seq){chomp($seq);
          if($seq=~/$id##/){

           ($id,$seq_lc)=split("##",$seq);

#print $seq_lc;
            if($seq_lc=~/([st]+)/){$pos=length($`);$count++;}
$pos[$i++]=$pos+1;
$seq1=uc($seq_lc)
 #   print $pos." ";  
 }
 	}print FA1 "@pos";
@pos=();$i=0;print FA $seq1;

}
print FA1 $count;
