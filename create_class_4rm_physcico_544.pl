#!/usr/bin/perl -w
#use strict;
# add your ~/lib dir to @INC
#use lib '/home/nishant/lib/';
# proceed as usual
 #      use Statistics::Lite qw(:all);
  #      $min= min @data;
   #     $mean= mean @data;
#        %data= statshash @data;
        #print "sum= $data{sum} stddev= $data{stddev}\n";
 #       print statsinfo(@data);
  #      %std=statsinfo(@data);
        #print $std{'stddev'}
open(FH,$ARGV[0]);
@lines=<FH>;
close FH;

open(OUT,">$ARGV[1]");

foreach $line(@lines){
chomp($line);
@split=split("##",$line);
undef @data;
@data=split("\t",$split[1]);
@sort=sort(@data);
print  OUT ">$split[0]##";
#\t@sort\n!!!!!!!!!!!!!!!!!!!!!!!!!!!";
        
print count(@data); 
print "\nmean:".mean(@data);
print "\nmax:".max(@data);
$max=max(@data);
$min=min(@data);
print "\nmin:".min(@data);
print "\nmedien:".median(@data);
print "\nstddev:".stddev(@data);
print "\nrange:".range(@data);
$range=range(@data);
$num3=$range/3;
$c3=$num3*2;
foreach $number(@data){

if(($number >=($min+$num3))&& ($number<($max-$num3))){$class='2';}
if($number<($min+$num3)){$class='1';}
if($number>=($max-$num3)){$class='3';}
print OUT $class."\t";

}
print OUT "\n";
print "\n\n";       
}        
sub count
{ return scalar @_; }

sub min 
{
        return unless @_;
        return $_[0] unless @_ > 1;
        my $min= shift;
        foreach(@_) { $min= $_ if $_ < $min; }
        return $min;
}

sub max 
{
        return unless @_;
        return $_[0] unless @_ > 1;
        my $max= shift;
        foreach(@_) { $max= $_ if $_ > $max; }
        return $max;
}

sub range
{
        return unless @_;
        return 0 unless @_ > 1;
        return abs($_[1]-$_[0]) unless @_ > 2;
        my $min= shift; my $max= $min;
        foreach(@_) { $min= $_ if $_ < $min; $max= $_ if $_ > $max; }
        return $max - $min;
}
sub sum
{
        return unless @_;
        return $_[0] unless @_ > 1;
        my $sum;
        foreach(@_) { $sum+= $_; }
        return $sum;
}

sub mean
{
        return unless @_;
        return $_[0] unless @_ > 1;
        return sum(@_)/scalar(@_);
}

sub median
{
        return unless @_;
        return $_[0] unless @_ > 1;
        @_= sort{$a<=>$b}@_;
        return $_[$#_/2] if @_&1;
        my $mid= @_/2;
        return ($_[$mid-1]+$_[$mid])/2;
}

sub mode
{
        return unless @_;
        return $_[0] unless @_ > 1;
        my %count;
        foreach(@_) { $count{$_}++; }
        my $maxhits= max(values %count);
        foreach(keys %count) { delete $count{$_} unless $count{$_} == $maxhits; }
        return mean(keys %count);
}

sub variance
{
        return unless @_;
        return 0 unless @_ > 1;
        my $mean= mean @_;
        return (sum map { ($_ - $mean)**2 } @_) / $#_;
}

sub variancep
{
        return unless @_;
        return 0 unless @_ > 1;
        my $mean= mean @_;
        return (sum map { ($_ - $mean)**2 } @_) / ( $#_ +1 );
}

sub stddev
{
        return unless @_;
        return 0 unless @_ > 1;
        return sqrt variance @_;
}

sub stddevp
{
        return unless @_;
        return 0 unless @_ > 1;
        return sqrt variancep @_;
}
        
