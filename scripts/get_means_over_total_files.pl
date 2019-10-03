#!perl -w

use strict;

my $indir = shift(@ARGV) or die;
my $output = shift(@ARGV) or die;
unlink(qq{$output});

opendir DIR, "$indir";
my @files = grep {/\.total_sleep/} readdir DIR;
closedir DIR;

my %conv = ();
my @group = ();
my %data = ();
my %count = ();
my %g = ();
my %geno = ();
my @sex = ("M","F");
my @temp = (21,25);

foreach my $file (@files){
    print $file, "\n";
    open(A, "<$file");
    while(my $line = <A>){
	chomp $line;
	my @a = split(/\t/, $line);
	if($line =~ m/Genotype/){
	    for(my $i = 5; $i < scalar(@a); $i++){
		$conv{$i} = $a[$i];
		if(!(exists($g{$a[$i]}))){
		    push(@group,$a[$i]);
		    $g{$a[$i]} = 1;
		}
	    }
	}
	if($line !~ m/Genotype/){
	    $geno{$a[0]} = $a[1];
	    for(my $j = 5; $j < scalar(@a); $j++){
		if(!(exists($data{$conv{$j} . "\t" . $a[0] . "\t" . $a[1] . "\t" . $a[3] . "\t" . $a[4]}))){
		    
		    $data{$conv{$j} . "\t" . $a[0] . "\t" . $a[1] . "\t" . $a[3] . "\t" . $a[4]} = $a[$j];
		    $count{$conv{$j} . "\t" . $a[0] . "\t" . $a[1] . "\t" . $a[3] . "\t" . $a[4]} = 1;
		    
		}elsif(exists($data{$conv{$j} . "\t" . $a[0] . "\t" . $a[1] . "\t" . $a[3] . "\t" . $a[4]})){
		    
		    $data{$conv{$j} . "\t" . $a[0] . "\t" . $a[1] . "\t" . $a[3] . "\t" . $a[4]} = $a[$j] + $data{$conv{$j} . "\t" . $a[0] . "\t" . $a[1] . "\t" . $a[3] . "\t" . $a[4]};
		    $count{$conv{$j} . "\t" . $a[0] . "\t" . $a[1] . "\t" . $a[3] . "\t" . $a[4]}++;
		}
	    }
	}
    }
    close A;
}
open(B, ">>$output");
print B "Genotype\tPop\tTemp\tSex";
foreach my $g (@group){
    print B "\t", $g;
}
print B "\n";

while((my $k, my $v) = each(%geno)){
    foreach my $t (@temp){
	foreach my $s (@sex){
	    print B $k, "\t", $v, "\t", $t, "\t", $s; 
	    foreach my $g (@group){
		print B "\t", sprintf("%.3f",($data{$g . "\t" . $k . "\t" . $v . "\t" . $s . "\t" . $t} / $count{$g . "\t" . $k . "\t" . $v . "\t" . $s . "\t" . $t}));
	    }
	    print B "\n";
	}
    }
}
close B;

#$data{$g . "\t" . $p . "\t" . $s . "\t" . $t}, "\t", $count{$g . "\t" . $p . "\t" . $s . "\t" . $t}, "\t", 
