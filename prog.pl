#!/usr/bin/perl -w

$file=$ARGV[0];
open(RK,$file);
while($line=<RK>){
    chomp($line);

   if($line !~"^>"){
	print"$line\n";
}

}
