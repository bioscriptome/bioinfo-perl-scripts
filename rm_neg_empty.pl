#!/usr/perl/bin/ 


open(FH,$ARGV[0]);
    open(FA,">".$ARGV[1]);
@array=<FH>;
$line=0;
foreach $mot(@array){
    # chomp($mot);   
    #   if($mot!=~/^>[A-Z\-]+\n>.+/sg){print $mot."\n";}
    #}_
if($array[$line++]=~/>/){#print "\n".($line-1)."\n";
			 if($array[$line]=~/>/){next;
	}
	elsif($array[$line]=~/^[A-Z]/){
	    print FA $array[$line-1];
	    $u=$line;#print $array[$line-1]."\n";
		until($array[$u++]=~/>/){print FA $array[$u-1];
				     }
	}
	else{}
    }
}
