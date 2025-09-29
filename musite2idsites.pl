perl -n -e '$line=$_;chomp($line);if($line=~/>/){print "\n".$line."##";}else{$line=~/(\d+)\t[ST]\t/;print $1."\t"; }' 2879_DISEASE_27779_1-Sp_0.95.result.txt  >musite_95_2879_protein_is_sites
