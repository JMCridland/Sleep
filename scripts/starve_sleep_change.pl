#!perl -w

use strict;

my $input = shift(@ARGV) or die; #Total_sleep_all_dates
my $starve = shift(@ARGV) or die; #Starve_means.txt
my $output = shift(@ARGV) or die;
unlink(qq{$output});
my $output2 = shift(@ARGV) or die;
unlink(qq{$output2});

my %data = ();
my %datacounts = ();
my %day = ();
my %daycounts = ();
my %night = ();
my %nightcounts = ();

open(D, ">>$output2");
print D "Date\tGenotype\tPop\tNum\tSex\tTemp\tAlldiff\tDaydiff\tNightdiff\n";
open(A, "<$input");
while(my $line = <A>){
    chomp $line;
    if($line !~ m/Date/){
	my @a = split(/\t/, $line);

	my $allval = ((($a[18] - $a[6]) / $a[6]) * 100);

	my $dayval = ((($a[22] - $a[10]) / $a[10]) * 100);

	my $nightval = ((($a[26] - $a[14]) / $a[14]) * 100);

####Key is Genotype Pop Sex Temp

	print D $a[0], "\t", $a[1], "\t", $a[2], "\t", $a[3], "\t", $a[4], "\t", $a[5], "\t", $allval, "\t", $dayval, "\t", $nightval, "\n";
	
	if(!(exists($data{$a[1] . "\t" . $a[2] . "\t" . $a[4] . "\t" . $a[5]}))){  
	    $data{$a[1] . "\t" . $a[2] . "\t" . $a[4] . "\t" . $a[5]} = $allval;
	    $datacounts{$a[1] . "\t" . $a[2] . "\t" . $a[4] . "\t" . $a[5]} = 1;
	}elsif(exists($data{$a[1] . "\t" . $a[2] . "\t" . $a[4] . "\t" . $a[5]})){
	    $data{$a[1] . "\t" . $a[2] . "\t" . $a[4] . "\t" . $a[5]} = $allval + $data{$a[1] . "\t" . $a[2] . "\t" . $a[4] . "\t" . $a[5]};
	    $datacounts{$a[1] . "\t" . $a[2] . "\t" . $a[4] . "\t" . $a[5]}++;
	}

	if(!(exists($day{$a[1] . "\t" . $a[2] . "\t" . $a[4] . "\t" . $a[5]}))){
	    $day{$a[1] . "\t" . $a[2] . "\t" . $a[4] . "\t" . $a[5]} = $dayval;
	    $daycounts{$a[1] . "\t" . $a[2] . "\t" . $a[4] . "\t" . $a[5]} = 1;
	}elsif(exists($day{$a[1] . "\t" . $a[2] . "\t" . $a[4] . "\t" . $a[5]})){
	    $day{$a[1] . "\t" . $a[2] . "\t" . $a[4] . "\t" . $a[5]} = $dayval + $day{$a[1] . "\t" . $a[2] . "\t" . $a[4] . "\t" . $a[5]};
	    $daycounts{$a[1] . "\t" . $a[2] . "\t" . $a[4] . "\t" . $a[5]}++;
	}
	
	if(!(exists($night{$a[1] . "\t" . $a[2] . "\t" . $a[4] . "\t" . $a[5]}))){
	    $night{$a[1] . "\t" . $a[2] . "\t" . $a[4] . "\t" . $a[5]} = $nightval;
	    $nightcounts{$a[1] . "\t" . $a[2] . "\t" . $a[4] . "\t" . $a[5]} = 1;
	}elsif(exists($data{$a[1] . "\t" . $a[2] . "\t" . $a[4] . "\t" . $a[5]})){
	    $night{$a[1] . "\t" . $a[2] . "\t" . $a[4] . "\t" . $a[5]} = $nightval + $night{$a[1] . "\t" . $a[2] . "\t" . $a[4] . "\t" . $a[5]};
	    $nightcounts{$a[1] . "\t" . $a[2] . "\t" . $a[4] . "\t" . $a[5]}++;
	}   

    }
}
close A;
close D;

my %ld50 = ();

#this is the master table has LD50 info
open(C, "<$starve");
while(my $line2 = <C>){
    chomp $line2;
    my @c = split(/\t/, $line2);
    ####Key is Genotype Pop Sex Temp
    $ld50{$c[0] . "\t" . $c[1] . "\t" . $c[2] . "\t" . $c[3]} = $c[4];
    
}
close C;

####now get means over individual calculations for sex / pop / temp / date combinations

open(B, ">>$output");
print B "Genotype\tPop\tSex\tTemp\tALL\tDay\tNight\tLD50\n";
while((my $k, my $v) = each(%data)){
    
    print B $k, "\t", ($data{$k} / $datacounts{$k}), "\t", ($day{$k} / $daycounts{$k}), "\t", ($night{$k} / $nightcounts{$k}), "\t", $ld50{$k}, "\n";
}
close B;
