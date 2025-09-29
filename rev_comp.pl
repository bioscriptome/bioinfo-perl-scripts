$revcom = reverse $DNA;

# The Perl translate/transliterate command is just what we need:
$revcom =~ tr/ACGTacgt/TGCAtgca/;
return $revcom;
