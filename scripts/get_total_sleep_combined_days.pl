#!perl -w

use strict;

#I need to get total sleep time for each individual for day / night  starve/ sleep

my $indir = shift(@ARGV) or die;
my $output = shift(@ARGV) or die;
unlink(qq{$output});

opendir DIR, "$indir";
my @indir = grep{/_grouped_data/} readdir DIR;
closedir DIR;

my %data = ();  #total minutes of sleep
my %bouts = (); #number of bouts
my %meanbouts = (); #mean length per bout
my %counts = (); #
my %cat = ();
my @cat = ();
my %time = (); #keep track of total time for each section

my @group = ();
my %group = ();
my @sex = ("M","F");

my %move = ();
my %movecount = ();

my @temp = (21,25);

my @id = (); #the individual genotype
my %id = ();

my @num = (); #the individual number
my %num = ();

foreach my $input (@indir){ #I want to get sleep data only for flies
    
    #I need to total Sleep for Day & Night, Sleep and Starved and mean move per minute Day night Sleep / Starved
    #I also need total time for the whole section
        
    open(A, "<$input");

    print $input, "\n";
    
    while(my $line = <A>){
	chomp $line;
	my @a = split(/\t/, $line);
	
	my $id = $a[3];  #this is the pop
	
	$id =~ s/\d+//;
	
	my @b = split(/_/, $a[0]);
	
	$b[1] =~ s/\d+//;
	
	my $group = $b[0] . "_" . $b[1];  #what time period
	
	if(!(exists($group{$group}))){  #store time periods
	    push(@group, $group);
	    $group{$group} = 1;
	}
	
	#$temp{$d[0]} = $a[4]; #store the temperature for this group
	
	if(!(exists($id{$a[3]}))){
	    $id{$a[3]} = 1;
	    push(@id, $a[3]);
	}	
	
	if($a[1] =~ m/Sleep/){
	    if(!(exists($cat{$group}))){
		
		$cat{$group} = 1; #categories to check		
		push(@cat, $group);
	    }
	    
	    if($a[9] ne "NA"){
		my @c  = split(/,/, $a[9]);
		
		my $high = 0;
		foreach my $z (@c){
		    
		    if($z > $high){
			$high = $z;
		    }
		}
		if(($high < 720)){ #720 marks a whole 12 hour sleep period
		    
		    ##sex pop geno temp
		    if(!(exists($data{$group . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4]}))){
			
			###Data hash contains total time sleeping
			$data{$group . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4]} = $a[6];
			
			##bouts hash contains total number of bouts
			$bouts{$group . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4]} = $a[7];
			
			##mean bouts contains mean bout length for measured time - 
			$meanbouts{$group . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4]} = $a[8];
			
			###how many times do I see this grouping - i.e. sleep day 1 and sleep day 2
			$counts{$group . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4]} = 1;
			
		    }elsif(exists($data{$group . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4]})){
			
			if($data{$group . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4]} !~ m/NA/){
			    
			    $data{$group . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4]} = $a[6] + $data{$group . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4]};
			    
			    $bouts{$group . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4]} = $a[7] + $bouts{$group . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4]};
			    
			    $meanbouts{$group . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4]} = $a[8] + $meanbouts{$group . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4]};
			    
			    $counts{$group . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4]}++;
			}
		    }
		}else{		
		    #	print $line, "\n";
		}
	    }
	    #this is calculating the total time for that portion of the experiment
	    if(!(exists($time{$group . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4]}))){
		
		$time{$group . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4]} = $a[6];
		
	    }elsif(exists($time{$group . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4]})){
		
		$time{$group . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4]} = $a[6] + $time{$group . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4]};
		
	    }
	    
	}elsif($a[1] =~ m/Movement/){ 
	    
	    if($a[8] !~ m/NA/){ ### adding to the total time
		my @t = split(/,/, $a[9]);
		#	print scalar(@t), "\t", join(",", @t), "\n";
		
		if(!(exists($time{$group . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4]}))){
		    
		    $time{$group . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4]} = scalar(@t);
		    
		}elsif(exists($time{$group . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4]})){
		    
		    $time{$group . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4]} = $time{$group . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4]} + scalar(@t);
		    #	    print "adding \n";
		    
		}		
		
		if(!(exists($move{$group . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4]}))){
		    
		    $move{$group . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4]} = $a[8];
		    $movecount{$group . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4]} = 1;
		    
		}elsif(exists($move{$group . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4]})){
		    
		    $move{$group . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] } = $a[8] + $move{$group . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4]};
		    $movecount{$group . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4]}++;
		}
	    }else{
		#	print $line, "\n";
	    }
	}
    }
    close A;
}

open(B, ">>$output");
print B "Genotype\tPop\tSex\tTemp";

foreach my $group (@group){
    print B "\t", $group, "_percent", "\t", $group, "_boutNum", "\t", $group, "_meanBout", "\t", $group, "_meanMove";
}
print B "\n";

##Sex pop geno temp 

foreach my $id (@id){ #this is the genotype
    
    my $pop = $id;
    $pop =~ s/\d+//;
    
    foreach my $sex (@sex){
	
	foreach my $temp (@temp){
	    
	    print B $id, "\t", $pop, "\t",  $sex, "\t", $temp;
	    
	    foreach my $group (@group){ #which group
		
		print B "\t", sprintf("%.3f",($data{$group . "\t" . $sex . "\t" . $pop . "\t" . $id . "\t" . $temp} / $time{$group . "\t" . $sex . "\t" . $pop . "\t" . $id . "\t" . $temp})), "\t", 
		
		sprintf("%.1f",($bouts{$group . "\t" . $sex . "\t" . $pop . "\t" . $id . "\t" . $temp} / $counts{$group . "\t" . $sex . "\t" . $pop . "\t" . $id . "\t" . $temp})), "\t",  
		
		sprintf("%.3f",($meanbouts{$group . "\t" . $sex . "\t" . $pop . "\t" . $id . "\t" . $temp} / $counts{$group . "\t" . $sex . "\t" . $pop . "\t" . $id . "\t" . $temp})), "\t",
		
		sprintf("%.3f",($move{$group . "\t" . $sex . "\t" . $pop . "\t" . $id . "\t" . $temp} / $movecount{$group . "\t" . $sex . "\t" . $pop . "\t" . $id . "\t" . $temp})),
	    }
	    print B "\n";		
	}
    }
}
close B;    




my $output2 = $date . ".percent_day_sleep";
unlink(qq{$output2});

open(C, ">>$output2");
print C "Genotype\tPop\tNum\tSex\tTemp\tSleepDay\tSleepNight\tSleepDayPercent\tStarveDay\tStarveNight\tStarveDayPercent\n";
	    print C $id, "\t", $pop, "\t", $num, "\t", $sex{$num}, "\t", $temp{$date}, "\t";

	print C $data{"Sleep_Day" . "\t" . $date . "\t" . $sex{$num} . "\t" . $pop . "\t" . $id . "\t" . $temp{$date} . "\t" . $num}, "\t", 
		$data{"Sleep_Night" . "\t" . $date . "\t" . $sex{$num} . "\t" . $pop . "\t" . $id . "\t" . $temp{$date} . "\t" . $num}, "\t", 
		sprintf("%.3f",($data{"Sleep_Day" . "\t" . $date . "\t" . $sex{$num} . "\t" . $pop . "\t" . $id . "\t" . $temp{$date} . "\t" . $num} / ($data{"Sleep_Day" . "\t" . $date . "\t" . $sex{$num} . "\t" . $pop . "\t" . $id . "\t" . $temp{$date} . "\t" . $num} + $data{"Sleep_Night" . "\t" . $date . "\t" . $sex{$num} . "\t" . $pop . "\t" . $id . "\t" . $temp{$date} . "\t" . $num}))), "\t",
		 
		$data{"Starve_Day" . "\t" . $date . "\t" . $sex{$num} . "\t" . $pop . "\t" . $id . "\t" . $temp{$date} . "\t" . $num}, "\t", 
		$data{"Starve_Night" . "\t" . $date . "\t" . $sex{$num} . "\t" . $pop . "\t" . $id . "\t" . $temp{$date} . "\t" . $num}, "\t", 
		sprintf("%.3f",($data{"Starve_Day" . "\t" . $date . "\t" . $sex{$num} . "\t" . $pop . "\t" . $id . "\t" . $temp{$date} . "\t" . $num} / ($data{"Starve_Day" . "\t" . $date . "\t" . $sex{$num} . "\t" . $pop . "\t" . $id . "\t" . $temp{$date} . "\t" . $num} + $data{"Starve_Night" . "\t" . $date . "\t" . $sex{$num} . "\t" . $pop . "\t" . $id . "\t" . $temp{$date} . "\t" . $num}))), "\n"; 
		

close C;
