if($ARGV[0] eq ''){print "Usage: perl col2svm.pl scorefile fileone file2 ....\n ";}
else{($score,@files)=@ARGV;
	system "paste -d ',' @files >OUT_TEMP";
	#system "paste -d ' ' $score OUT_TEMP >final";
	open(COL,"OUT_TEMP");
	open(SVM,">TEMP_SVM");
	@col=<COL>;
	foreach $line (@col){
		chomp($line);
		$n=0;
		@split=split(",",$line);
		foreach $col(@split){
			$n++;
			print SVM "$n:$col ";
			}
		print SVM "\n";
		}
system "paste -d ' ' $score TEMP_SVM >temp_svm_fin";
system "cat temp_svm_fin";
system "rm OUT_TEMP  TEMP_SVM temp_svm_fin";
}
