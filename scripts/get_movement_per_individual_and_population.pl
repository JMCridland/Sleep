#!perl -w

use strict;

my $sleep = shift(@ARGV) or die; #the movement data with the sleep info
my $starve = shift(@ARGV) or die; #same but with starve info
my $output = shift(@ARGV) or die;
unlink(qq{$output});
my $output2 = shift(@ARGV) or die;
unlink(qq{$output2});


my @files = ($sleep,$starve);

my %conv = ();
my %sum = ();
my %num = ();

open(A, "<$sleep");  #first open this file and scan to find dead flies - record this
while(my $line = <A>){
    chomp $line;
    my @a = split(/\t/, $line);
    if($line =~ m/Date/){
	for(my $i = 5; $i < scalar(@a); $i++){
	    $conv{$i} = $a[$i];
	}
    }else{
	for(my $j = 5; $j < scalar(@a); $j++){
	    if(!(exists($sum{$a[2] . "\t" . $conv{$j}}))){
		$sum{$a[2] . "\t" . $conv{$j}} = $a[$j];
	    }elsif(exists($sum{$a[2] . "\t" . $conv{$j}})){
		$sum{$a[2] . "\t" . $conv{$j}} = $a[$j] + $sum{$a[2] . "\t" . $conv{$j}};
	    }
	}
    }
}
close A;

my %geno = ();
my %val = ();
my %count = ();

my @type = ("Sleep","Starve");
my @sex = ("M","F");
my @g = (); #genotype
my %g = ();
my @times = (); #time
my %times = ();

foreach my $file (@files){
    open(A, "<$file");
    while(my $line = <A>){
	chomp $line;
	my @a = split(/\t/, $line);
	
	if($line !~ m/Date/){
	    if(!(exists($g{$a[2]}))){ #save set of genotypes
		$g{$a[2]} = 1;
		push(@g, $a[2]);
	    }
	    if(!(exists($times{$a[1]}))){ #save set of times
		$times{$a[1]} = 1;
		push(@times, $a[1]); #push times observed - input file will be in order
	    }
	    
	    for(my $j = 5; $j < scalar(@a); $j++){  #go over the line
	
		if($sum{$a[2] . "\t" . $conv{$j}} > 0){		    
		    if($conv{$j} =~ m/M/){		   
			
			my $mval = $a[2] . "\t" . "M" . "\t" . $a[4] . "\t" . $a[1];  #Geno Sex Category Time
			
			push(@{$val{$mval}}, $a[$j]);  #geno \t sex \t group \t time
			
			if(!(exists($geno{$mval}))){
			    $geno{$mval} = $a[$j];
			    $count{$mval} = 1;
			}elsif(exists($geno{$mval})){
			    $geno{$mval} = $geno{$mval} + $a[$j];
			    $count{$mval}++;
			}
		    }elsif($conv{$j} =~ m/F/){
			
			my $fval = $a[2] . "\t" . "F" . "\t" . $a[4] . "\t" . $a[1];
			
			push(@{$val{$fval}}, $a[$j]);
			
			if(!(exists($geno{$fval}))){
			    $geno{$fval} = $a[$j];
			    $count{$fval} = 1;
			}elsif(exists($geno{$fval})){
			    $geno{$fval} = $geno{$fval} + $a[$j];
			    $count{$fval}++;
			}  			
		    }
		}
	    }
	}
    }
    close A; 
}

my %popdata = ();
my %popcount = ();
my %popval = ();
my @pop = ();
my %p = ();

open(B, ">>$output");
print B "Geno\tSex\tGroup\tTime\tMean\tSD\n";
foreach my $g (@g){ #genotype
    foreach my $s (@sex){
	foreach my $x (@type){
	    foreach my $t (@times){ #time	  	  		
		#Geno Sex Category Time
		my $current = $g . "\t" . $s . "\t" . $x . "\t" . $t;

		my $sd = 0;
		my $mean = 0;
		my $std = 0;
		
		if(exists($geno{$current})){
		    
		    if($geno{$current} > 0){
			
			#now calculate SD for each one
			
			$mean = ($geno{$current} / $count{$current});
			
			foreach my $m (@{$val{$current}}){
			    $sd += ($mean - $m) ** 2;
			}
			$std = ($sd / ($count{$current} - 1)) ** 0.5;
		    }
		    
		    ###now get calculations for population
		    
		    my $newpop = $g;
		    $newpop =~ s/\d+//;
		   # print $newpop, "\n";

		    if(!(exists($p{$newpop}))){

			$p{$newpop} = 1;
			push(@pop, $newpop);
		    }
		    my $pop = $newpop . "\t" . $s . "\t" . $x . "\t" . $t;
		    #    print $pop, "\n";
		   
		    push(@{$popval{$pop}}, $mean);
		    if(!(exists($popdata{$pop}))){
			$popdata{$pop} = $mean;
			$popcount{$pop} = 1;
		    }elsif(exists($popdata{$pop})){
			$popdata{$pop} = $popdata{$pop} + $mean;
			$popcount{$pop}++;
		    }
		    ######End population calculations
		    
		    print B $current, "\t", sprintf("%.3f",$mean), "\t", sprintf("%.3f",$std), "\n"; 
		}
	    }
	}
    }
}
close B;

open(D, ">>$output2");
print D "Pop\tSex\tGroup\tTime\tMean\tSD\n";
foreach my $p (@pop){ #genotype
    foreach my $s (@sex){
	foreach my $x (@type){
	    foreach my $t (@times){ #time
		#Geno Sex Category Time
		my $current = $p . "\t" . $s . "\t" . $x . "\t" . $t;

	#	print $current, "\n";
		my $sd = 0;
		my $mean = 0;
		my $std = 0;
		
		if(exists($popdata{$current})){
		    
		    if($popdata{$current} > 0){
			
			#now calculate SD for each one
			
			$mean = ($popdata{$current} / $popcount{$current});
			
			foreach my $m (@{$popval{$current}}){
			    $sd += ($mean - $m) ** 2;
			}
			$std = ($sd / ($popcount{$current} - 1)) ** 0.5;
		    }
		    print D $current, "\t", sprintf("%.3f",$mean), "\t", sprintf("%.3f",$std), "\n";
		}
	    }
	}
    }
}
close D;
