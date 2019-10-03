#!perl -w

use strict;

my $g21 = shift(@ARGV) or die;
my $g25 = shift(@ARGV) or die;
my $output = shift(@ARGV) or die;
unlink(qq{$output});

open(B, ">>$output");
open(A, "<$g21");
print B "Genotype\tPop\tSex\tTemp\tGluPro\tGluCanS\n";
while(my $line = <A>){
    chomp $line;
    my @a = split(/\t/, $line);
    if($line !~ m/Genotype/){
	print B $a[0], "\t", $a[1], "\t", $a[2], "\t", "21", "\t", $a[8], "\t", $a[9], "\n";
    }
}
close A;
open(C, "<$g25");
while(my $line2 = <C>){
    chomp $line2;
    my @b = split(/\t/, $line2);
    if($line2 !~ m/Genotype/){
	print B $b[0], "\t", $b[1], "\t", $b[2], "\t", "25", "\t", $b[9], "\t", $b[10], "\n";
    }
}
close C;
close B;
