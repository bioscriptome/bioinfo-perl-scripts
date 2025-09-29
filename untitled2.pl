 #!/usr/bin/perl
$a=CAGACTCCCGCGGCAT;
for (my $key = 0; $key < length($a); $key+=4) {
print substr ($a, $key, 4)."\n";
}
