 use POSIX;
open(FH,$ARGV[0]);
open(FA,">".$ARGV[2]);
$num=$ARGV[1];
@array=<FH>;
$len=scalar(@array);
close FH;
$file=join('',@array);
#system "grep -c \">\" $ARGV[0]"
$file=~s/>/#>/g;
$file=~s/\n/\t/g;
@array1=split('#',$file);
$length=scalar(@array1);
print $length."\n";
$ran=$num/$length;

    $ran   = ceil($ran);                     
#print $ran;


$count=0;

$id_count=0;


foreach(@array1){
#print FA $_."\n";
($id,$mots)=split(" \t",$_);
@mots=split("\t",$mots);
$mot_len=scalar(@mots);
#print @mots;
@arrayRandom=();@unique_array=();
@mots_num=();
#print $ran;
unless(scalar(@unique_array) eq ($ran)){
for($x=0;$x<$ran;$x++)
{
$random_number= int (rand($mot_len));
push (@mots_num,$random_number);    }
my %seen =() ;
@unique_array = grep { ! $seen{$_}++ } @mots_num ; 
}
#print scalar(@unique_array)."\n";
print FA $id."\n";
    $id_count++;
foreach $ran1(@unique_array)
{ 
#print $ran1."\n";
    $count++;
print FA "$mots[$ran1]\n";
}#print "\n";




}

print $count."\n";
