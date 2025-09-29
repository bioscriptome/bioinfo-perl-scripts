#!/usr/bin/perl

############################### Header Information ##############################
require 'cgi.perl';
use CGI;
$query = new CGI;
&ReadParse;
print &PrintHeader;
################################ Reads Inoput Data ##############################
$name = $query->param('name');
$email = $query->param('email');
$seq = $query->param('seq');
$file = $query->param('file');
$svm_th = $query->param('svm_th');

#print "$name:$email:$seq:$file:$svm_th\n";
#################Validation Of Input Sequence Data (file upload) ###################################

if($file ne '' && $seq eq '')
{
    $file=~m/^.*(\\|\/)(.*)/; 
    while(<$file>) 
    {
	$seqfi .= $_;
#	$seqfi .= $file;
#	print "FILE:$file\n";
    }
}
elsif($seq ne '' && $file eq ''){

    $seqfi="$seq";
}

##############ACTUAL PROCESS BEGINS FROM HERE#######################

#$ran= int(rand 10000);
$ran="1276654712";
$dir = "/usr1/webserver/cgidocs/tmp/ppredyeast/1276654712";
#system "mkdir $dir";
system "chmod 777 $dir";

#$dir3 = "/usr1/webserver/cgidocs/tmp/nadbinder/ppredyeast";
#system "mkdir $dir3";
system "chmod 777 $dir/seq";

$nam = "seq";
open(FP1,">$dir/$nam");
if($seqfi !~ m/\>/)
{
    print FP1 ">seq\n";
}
print FP1 "$seqfi\n";
close FP1;

open(FP9,">>/usr1/webserver/cgibin/ppredyeast/progs/job.que"); # BUILD LIST OF PENDING JOBS
##print FP9 "$dir:$svm_th:";
print FP9 "$ran:$svm_th:";

if($email ne '')
{
    print FP9 "$email:";
}
else
{
    print FP9 "-:";
}

if($name ne '')
{
    print FP9 "$name\n";
}
else
{
    print FP9 "-\n";
}


close(FP9);

$jobno=$ran;

if($email eq ""){

print  "<html>";
print "<head><title>nadbinder: Prediction of NAD interacting residues</title>\n";
print "<meta HTTP-EQUIV=content-type name=description content=nadbinder: Prediction of NAD interacting residues>\n";
print "<meta name=keywords content=NAD interacting residues prediction>\n";
print "<meta name=author content= Hifzur Rahman Ansari, G.P.S. Raghava, BIC, IMTECH>\n";
print "<meta name=generator content=Written by Hifzur Rahman Ansari, G.P.S. Raghava in html>\n";
print "<meta http-equiv=\"refresh\" content=\"20;url=http://www.imtech.res.in/cgibin/ppredyeast/progs/chkres?$jobno\">\n";
print "</HEAD>";
print "<body bgcolor=white>\n";
print "<br><br>\n";
print "<center>\n";
print "<font size=4 color=#008000><B>Thanks for using nadbinder server.</B><br>";
print "<p>";

print "<B>Please contact G. P. S. Raghava <a href='mailto:raghava\@imtech.res.in'><font size=4 color=blue>[raghava\@imtech.res.in\]</font></a>, if you face a
ny problem or you have any suggestions.</B><br><h5></p>";
print "<p>";
print "<font size=4 color=#008000>Your job has been submitted and your job number is <font size=4 color=red>$jobno</font></p>";
print "<p>";
print "You can also check your results <a href=\"/cgibin/ppredyeast/progs/chkres?$jobno\"> <font size=4 color=blue>HERE</font></a>.<br></p>";
print "</FONT>\n";
print "</body>";
print "</html>";
		}
elsif($email ne ""){
print  "<html>";
print "<head><title>nadbinder: Prediction of NAD interacting residues</title>\n";
print "<meta HTTP-EQUIV=content-type name=description content=nadbinder: Prediction of NAD interacting residues>\n";
print "<meta name=keywords content=NAD interacting residues prediction";
print "<meta name=author content= Hifzur Rahman Ansari, G.P.S. Raghava, BIC, IMTECH>\n";
print "<meta name=generator content=Written by Hifzur Rahman Ansari, G.P.S. Raghava in html>\n";
print "<meta http-equiv=\"refresh\" content=\"20;url=http://www.imtech.res.in/cgibin/ppredyeast/progs/chkres?$jobno\">\n";
print "</HEAD>";
print "<body bgcolor=white>\n";
print "<br><br>\n";
print "<center>\n";
print "<font size=4 color=#008000><B>Thanks for using nadbinder server.</B><br>";
print "<p>";

print "<B>Please contact G. P. S. Raghava <a href='mailto:raghava\@imtech.res.in'><font size=4 color=blue>[raghava\@imtech.res.in\]</font></a>, if you face any problem or you have any suggestions.</B><br><h5></p>";
print "<p>";
print "<font size=4 color=#008000>Your job has been submitted and your job number is <font size=4 color=red>$jobno</font></p>";
print "<p>";
print "<font size=4 color=#008000>The results will be send to you at <font color=blue>$email</font> or will be displayed on current screen after job completion.";
 print "<p>";
print "You can also check your results <a href=\"/cgibin/ppredyeast/progs/chkres?$jobno\"> <font size=4 color=blue>HERE</font></a> after completion.<br></p>";
print "</FONT>\n";
print "</body>";
print "</html>";

#system "/usr/bin/perl /usr1/webserver/cgibin/nadbinder/mail.pl $jobno $name $email";
}

