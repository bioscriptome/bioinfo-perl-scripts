#!/usr/bin/perl 
use Getopt::Std;
getopts('i:p:w:');
$file1=$opt_i;
$win=$opt_w;
open(FILES,$file1);
@files=<FILES>;
close FILES;
$prog=$opt_p;
#$file1=~/(.+)\..+$/;
#$name=$1;
if($file1 eq ''){}
else{
if($prog =~/fasta2sfasta/){ 
	open(SFASTA,">LIST_SFASTA");
        foreach $line(@files){
        chomp($line);
        if($line=~/(.+)\..+$/){
        $name=$1;
        print SFASTA "$name\.sfasta\n";
        system "perl ~/progs/fasta2sfasta -i $line -o $name\.sfasta";
        }}
        close SFASTA;
}
if($prog =~/contact/){
        open(CONTACT,">CONTACT_LIST");
        foreach $line(@files){
        chomp($line);
        if($line=~/(.+)\..+$/){
        $name=$1;
        @win=split(",",$win);
        foreach $win1(@win){
        $winu="w".$win1;
        system "mkdir $winu";
        print CONTACT "./$winu/$name\_$win1\.mot\n";
        system "perl ~/progs/make_contactPattern.pl  $line $win1 ./$winu/$name\_$win1\.mot";
        }
        }
        }
        close CONTACT;
}

if($prog =~/aac/){
	open(ACC,">LIST_ACC");
	foreach $line(@files){
	chomp($line);
	$line=~/(.+)\..+$/;
	$name=$1;
        print ACC "$name\.aac\n";	
	system "perl ~/gpsr_1.0/bin/pro2aac -i $line -o $name\.aac";
	}
	close AAC;
}
if($prog =~/dpc/){
	open(DPC,">LIST_DPC");
        foreach $line(@files){
        chomp($line);
        $line=~/(.+)\..+$/;
        $name=$1;
        print DPC "$name\.dpc\n";	       
        system "perl ~/gpsr_1.0/bin/pro2dpc -i $line -o $name\.dpc";
        }
        close DPC;
}

if($prog =~/bin/){
	open(BIN,">LIST_BIN");
        foreach $line(@files){
        chomp($line);
        $line=~/(.+)\..+$/;
        $name=$1;
        print BIN "$name\.bin\n";
        system "perl ~/gpsr_1.0/bin/motif2bin_sfasta -i $line -o $name\.bin -x y";
        }
        close BIN;
}

if($prog =~/col2svm/){
	open(SVM,">LIST_SVM");
        foreach $line1(@files){
        chomp($line1);
        @array=split(",",$line1);
        $line=$array[0];
        $tag=$array[1];
        $line=~/(.+)\..+$/;
        $name=$1;
        print SVM "$name\.svm\n";
        system "perl ~/gpsr_1.0/bin/col2svm -i $line -o $name\.svm -s $tag";
        }
}

if($prog =~/aac_dpc/){
	open(ACC_DPC,">LIST_ACC_DPC");
	foreach $line(@files){
	chomp($line);
	$line=~/(.+)\..+$/;
	$name=$1;
        print ACC_DPC "$name.aac_dpc\n";	
	system "perl ~/gpsr_1.0/bin/pro2aac -i $line -o $name\.aac";
        system "perl ~/gpsr_1.0/bin/pro2dpc -i $line -o $name\.dpc";
        system "paste -d ',' $name\.aac	$name\.dpc > $name\.aac_dpc";
	}
	close AAC_DPC;
}

if($prog =~/aac_bin/){
	open(ACC_BIN,">LIST_ACC_BIN");
	foreach $line(@files){
	chomp($line);
	$line=~/(.+)\..+$/;
	$name=$1;
        print ACC_BIN "$name.aac_bin\n";	
	system "perl ~/gpsr_1.0/bin/pro2aac -i $line -o $name\.aac";
        system "perl ~/gpsr_1.0/bin/motif2bin_sfasta -i $line -o $name\.bin -x y";
        system "paste -d ',' $name\.aac	$name\.bin > $name\.aac_bin";
	}
	close AAC_BIN;
}
if($prog =~/dpc_bin/){
	open(DPC_BIN,">LIST_DPC_BIN");
	foreach $line(@files){
	chomp($line);
	$line=~/(.+)\..+$/;
	$name=$1;
        print DPC_BIN "$name.dpc_bin\n";	
        system "perl ~/gpsr_1.0/bin/pro2dpc -i $line -o $name\.dpc";
        system "perl ~/gpsr_1.0/bin/motif2bin_sfasta -i $line -o $name\.bin -x y";
        system "paste -d ',' $name\.dpc	$name\.bin > $name\.dpc_bin";
	}
	close DPC_BIN;
}

if($prog =~/inverse/){
	open(INVERSE,">LIST_INVERSE");
        foreach $line(@files){
        chomp($line);
        $line=~/(.+)\.(.+)$/;
        $name=$1;$ext=$2;
	system "mkdir $name";
	print INVERSE "$line\ninverse\_$name\.$ext\n";
	$ret=`grep $name $file1`;
	chomp($ret);
	print "grep -v $name $file1|xargs cat >./$name/inverse\_$name\.$ext\n";
	system "cp $ret ./$name/.";
	system "grep -v $name $file1|xargs cat >./$name/inverse\_$name\.$ext";
#        print INVERSE "$name\.bin\n";

        }
        close INVERSE;
}

}

