#!perl -w

use strict;

my $starve = shift(@ARGV) or die;#Starve_means.txt
my $length = shift(@ARGV) or die;#Wing_length_means.txt
my $sleep = shift(@ARGV) or die; #Means_from_total_sleep_by_date - for percent sleep and movement
my $percent = shift(@ARGV) or die; #Percent_starve_sleep_diff
my $glu21 = shift(@ARGV) or die;#Glu_21C_means
my $glu25 = shift(@ARGV) or die;#Glu_25C_means
my $tga21 = shift(@ARGV) or die;#TGA_21C_means
my $tga25 = shift(@ARGV) or die;#TGA_25C_means
my $output = shift(@ARGV) or die;
unlink(qq{$output});

my %lenf = ();
my %lenq = ();
my %ld50 = ();

open(A, "<$starve");
while(my $line = <A>){
    chomp $line;
    my @a = split(/\t/, $line);
    if($line !~ m/Genotype/){
	$ld50{$a[0] . "\t" . $a[1] . "\t" . $a[2] . "\t" . $a[3]} = sprintf("%.3f",$a[4]); # . "\t" . sprintf("%.2f",$a[5]);  #Genotype Pop Sex Temp = LD50
    }
}
close A;

my %percent = ();
open(P, "<$percent");
while(my $line4 = <P>){
    chomp $line4;
    if($line4 !~ m/Genotype/){
	my @p = split(/\t/, $line4);
	$percent{$p[0] . "\t" . $p[1] . "\t" . $p[2] . "\t" . $p[3]} = sprintf("%.3f",$p[4]);
    }
}
close P;

open(B, "<$length");
while(my $line2 = <B>){
    chomp $line2;
    my @b = split(/\t/, $line2);
    if($b[4] eq "F"){

	$lenf{$b[0] . "\t" . $b[2] . "\t" . $b[3] . "\t" . $b[1]} = sprintf("%.3f",$b[5]); # . "\t" . sprintf("%.2f",$b[6]);
		  
    }elsif($b[4] eq "Q"){

	$lenq{$b[0] . "\t" . $b[2] . "\t" . $b[3] . "\t" . $b[1]} = sprintf("%.3f",$b[5]); # . "\t" . sprintf("%.2f",$b[6]);
    }
}
close B;

my %sleep = ();
my @groups = ();
my %g = ();

my %sconv = ();

open(C, "<$sleep");
while(my $line3 = <C>){
    chomp $line3;
    my @c = split(/\t/, $line3);
    
    if($line3 =~ m/Temp/){
	for(my $i = 4; $i < scalar(@c); $i++){
	    $sconv{$i} = $c[$i];
	    if(($c[$i] =~ m/percent/) or ($c[$i] =~ m/meanMove/)){
		push(@groups, $c[$i]);		
	    }
	}
    }else{
	for(my $j = 4; $j < scalar(@c); $j++){#Genotype Pop Sex Temp
	    if(($sconv{$j} =~ m/percent/) or ($sconv{$j} =~ m/meanMove/)){
		$sleep{$sconv{$j} . "\t" . $c[0] . "\t" . $c[1] . "\t" . $c[3] . "\t" . $c[2]} = sprintf("%.3f",$c[$j]);
	    }
	}
    }
}
close C;

my %glunorm = ();
my %gluCanS = ();
open(E, "<$glu21");
while(my $line = <E>){
    chomp $line;
    if($line !~ m/Mean/){
	my @e = split(/\t/, $line);
	$glunorm{$e[0] . "\t" . $e[1] . "\t" . $e[2] . "\t" . "21"} = sprintf("%.3f",$e[4]);
	$gluCanS{$e[0] . "\t" . $e[1] . "\t" . $e[2] . "\t" . "21"} = sprintf("%.3f",$e[7]);
    }
}
close E;


open(E, "<$glu25");
while(my $line = <E>){
    chomp $line;
    if($line !~ m/Mean/){
	my @e = split(/\t/, $line);
	$glunorm{$e[0] . "\t" . $e[1] . "\t" . $e[2] . "\t" . "25"} = sprintf("%.3f",$e[4]);
	$gluCanS{$e[0] . "\t" . $e[1] . "\t" . $e[2] . "\t" . "25"} = sprintf("%.3f",$e[7]);
    }
}
close E;

my %tganorm = ();
my %tgaCanS = ();
open(E, "<$tga21");
while(my $line = <E>){
    chomp $line;
    if($line !~ m/Mean/){
	my @e = split(/\t/, $line);
	$tganorm{$e[0] . "\t" . $e[1] . "\t" . $e[2] . "\t" . "21"} = sprintf("%.3f",$e[4]);
	$tgaCanS{$e[0] . "\t" . $e[1] . "\t" . $e[2] . "\t" . "21"} = sprintf("%.3f",$e[7]);
    }
}
close E;

open(E, "<$tga25");
while(my $line = <E>){
    chomp $line;
    if($line !~ m/Mean/){
	my @e = split(/\t/, $line);
	$tganorm{$e[0] . "\t" . $e[1] . "\t" . $e[2] . "\t" . "25"} = sprintf("%.3f",$e[4]);
	$tgaCanS{$e[0] . "\t" . $e[1] . "\t" . $e[2] . "\t" . "25"} = $e[7];
    }
}
close E;

open(D, ">>$output");

print D "Genotype\tPop\tSex\tTemp\tLD50_mean\tLenF_mean\tLenQ_mean\tPerChange\tGluNorm\tGluCanS\tTGANorm\tTGACanS";
foreach my $x (@groups){
    print D "\t", $x;
}
print D "\n";

while((my $k, my $v) = each(%ld50)){
    
    print D $k, "\t", $v;
    
    if(exists($lenf{$k})){
	print D "\t", $lenf{$k}, 
	
    }else{
	print D "\t", "NA";
    }
    if(exists($lenq{$k})){
	print D "\t", $lenq{$k};
    }else{
	print D "\t", "NA";
    }

    print D "\t", $percent{$k}, "\t", $glunorm{$k}, "\t", $gluCanS{$k}, "\t", $tganorm{$k}, "\t", $tgaCanS{$k};
    
    
    foreach my $x (@groups){
	if(exists($sleep{$x . "\t" . $k})){
	    print D "\t", sprintf("%.3f",$sleep{$x . "\t" . $k});
	}else{
	    print D "\t", "NA";
	}
    }

    print D "\n";
}
close D;
