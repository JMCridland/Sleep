#!perl -w

use strict;

#I need to get total sleep time for each individual for day / night  starve/ sleep

my $hourly = shift(@ARGV) or die; ##*hours_to_remove-  these are individual hours where the machine was turned off too soon - just remove that hour
my $remove = shift(@ARGV) or die; #*to_remove  - these are individuals that didn't move for an entire 12 hours - drop these for they are dead
my $input = shift(@ARGV) or die;
my $output = shift(@ARGV) or die;
unlink(qq{$output});

my %data = ();
my %count = ();
my %bouts = ();
my %meanbouts = ();
my %cat = ();
my @cat = ();

my %move = ();
my %movecount = ();

my %hour = ();

my $temp = 0;

open(H, "<$hourly");
while(my $line2 = <H>){
    chomp $line2;
    my @h = split(/\t/, $line2);
    $hour{$h[0] . "\t" . $h[1] . "\t" . $h[2] . "\t" . $h[3]} = 1;
}
close H;

my %remove = ();

open(R, "<$remove");
while(my $line3 = <R>){
    chomp $line3;
    my @r = split(/\t/, $line3);
    $remove{$r[0] . "\t" . $r[1] . "\t" . $r[2]} = 1;
}
close R;

my %sex = ();

my @id = (); #the individual genotype
my %id = ();

my @num = (); #the individual number
my %num = ();

open(A, "<$input");
while(my $line = <A>){
    chomp $line;
    my @a = split(/\t/, $line);
    
    my $id = $a[3];
    $id =~ s/\d+//;
    
    my @b = split(/_/, $a[0]);
    $b[1] =~ s/\d+//;
    
    my $group = $b[0] . "_" . $b[1] . "_" . $b[3];
    
    if(!(exists($remove{$a[3] . "\t" . $a[4] . "\t" . $a[5]}))){
	
	if(!(exists($hour{$a[0] . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]}))){

	    if($a[8] =~ m/NA/){ #because we are doing this by hour and we have already removed dead flies an NA should be zero sleep or move
		$a[8] = 0;
	    }
	    
	    if($a[1] =~ m/Sleep/){
		if(!(exists($cat{$group}))){
		    
		    $cat{$group} = 1; #categories to check		
		    push(@cat, $group);
		}
		
		$temp = $a[4]; #store the temperature for this group

		if(!(exists($id{$a[3]}))){
		    $id{$a[3]} = 1;
		    push(@id, $a[3]);
		}
		if(!(exists($num{$a[5]}))){
		    $num{$a[5]} = 1;
		    $sex{$a[5]} = $a[2];
		    push(@num, $a[5]);
		}
		
		
		if(!(exists($data{$group . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]}))){
		    
		    $data{$group . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]} = $a[6];
		    $count{$group . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]} = 1;
		    $bouts{$group . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]} = $a[7];
		    $meanbouts{$group . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]} = $a[8];
		    
		}elsif(exists($data{$group . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]})){
		    
		    if($data{$group . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]} !~ m/NA/){
			
			$data{$group . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]} = $a[6] + $data{$group . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]};
			$bouts{$group . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]} = $a[7] + $bouts{$group . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]};
			$meanbouts{$group . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]} = $a[8] + $meanbouts{$group . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]};
			$count{$group . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]}++;
		    }
		}
	    }elsif($a[1] =~ m/Movement/){

		if(!(exists($move{$group . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]}))){
		    
		    $move{$group . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]} = $a[8];
		    $movecount{$group . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]} = 1;
		    
		}elsif(exists($move{$group . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]})){
		    
		    
		    $move{$group . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]} = $a[8] + $move{$group . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]};
		    $movecount{$group . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]}++;
		
		}
	    }
	}
    }
}
close A;

my @sortnum = sort {$a <=> $b} @num;
 
open(B, ">>$output");
print B "Group\tTime\tHour\tSex\tPop\tGenotype\tTemp\tNum\tMeanTotalSleep\tMeanSleepBouts\tMeanSleepPerBout\tMeanMove\n";
while((my $k, my $v) = each(%cat)){
    my @y = split(/_/, $k);
    foreach my $id (@id){
	foreach my $num (@sortnum){
	    my $pop = $id;
	    $pop =~ s/\d+//;
	    if(exists($data{$k . "\t" . $sex{$num} . "\t" . $pop . "\t" . $id . "\t" . $temp . "\t" . $num})){
		print B $y[0], "\t", $y[1], "\t", $y[2], "\t", $sex{$num}, "\t", $pop, "\t", $id, "\t", $temp, "\t", $num, "\t", 
		($data{$k . "\t" . $sex{$num} . "\t" . $pop . "\t" . $id . "\t" . $temp . "\t" . $num} / $count{$k . "\t" . $sex{$num} . "\t" . $pop . "\t" . $id . "\t" . $temp . "\t" . $num}), "\t", 
		($bouts{$k . "\t" . $sex{$num} . "\t" . $pop . "\t" . $id . "\t" . $temp . "\t" . $num} / $count{$k . "\t" . $sex{$num} . "\t" . $pop . "\t" . $id . "\t" . $temp . "\t" . $num}), "\t", 
		sprintf("%.3f",($meanbouts{$k . "\t" . $sex{$num} . "\t" . $pop . "\t" . $id . "\t" . $temp . "\t" . $num} / $count{$k . "\t" . $sex{$num} . "\t" . $pop . "\t" . $id . "\t" . $temp . "\t" . $num})), "\t", 
		sprintf("%.3f",($move{$k . "\t" . $sex{$num} . "\t" . $pop . "\t" . $id . "\t" . $temp . "\t" . $num} / $movecount{$k . "\t" . $sex{$num} . "\t" . $pop . "\t" . $id . "\t" . $temp . "\t" . $num})), "\n"; 
	    }
	}
    }
}
close B;
