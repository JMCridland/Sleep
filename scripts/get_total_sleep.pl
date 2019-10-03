#!perl -w

use strict;

#I need to get total sleep time for each individual for day / night  starve/ sleep

my $indir = shift(@ARGV) or die;
#my $output = shift(@ARGV) or die;
#unlink(qq{$output});

opendir DIR, "$indir";
my @input = grep{/_grouped_data/} readdir DIR;
closedir DIR;

my %data = ();
my %bouts = ();
my %meanbouts = ();
my %counts = ();
my %cat = ();
my @cat = ();
my %time = (); #keep track of total time for each section

my @date = ();
my @group = ();
my %group = ();
my %sex = ();

my %move = ();
my %movecount = ();

my %temp = ();

my %remove = ();
$remove{"May3" . "\t" . "PC200"} = 1;
$remove{"May8" . "\t" . "FFD16"} = 1;

my @id = (); #the individual genotype
my %id = ();

my @num = (); #the individual number
my %num = ();

foreach my $input (@input){ #I want to get sleep data only for flies

    #I need to total Sleep for Day & Night, Sleep and Starved and mean move per minute Day night Sleep / Starved
    #I also need total time for the whole section
    
    my $date = $input;
    my @d = split(/_/, $date);

    push (@date, $d[0]);
    
    my $input = $indir . $input;
    
    open(A, "<$input");
    while(my $line = <A>){
	chomp $line;
	my @a = split(/\t/, $line);

	my $id = $a[3];

	$id =~ s/\d+//;

	my @b = split(/_/, $a[0]);
	
	$b[1] =~ s/\d+//;

	my $group = $b[0] . "_" . $b[1];
	
	if(!(exists($remove{$d[0] . "\t" . $a[3]}))){
	    if(!(exists($group{$group}))){
		push(@group, $group);
		$group{$group} = 1;
	    }
	    
	    $temp{$d[0]} = $a[4]; #store the temperature for this group
	    
	    if(!(exists($id{$a[3]}))){
		$id{$a[3]} = 1;
		push(@id, $a[3]);
	    }
	    if(!(exists($num{$a[5]}))){
		$num{$a[5]} = 1;
		$sex{$a[5]} = $a[2];
		push(@num, $a[5]);
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
			
			if(!(exists($data{$group . "\t" . $d[0] . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]}))){
			    
			    ###Data hash contains total time sleeping
			    $data{$group . "\t" . $d[0] . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]} = $a[6];
	        
			    ##bouts hash contains total number of bouts
			    $bouts{$group . "\t" . $d[0] . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]} = $a[7];
			    
			    ##mean bouts contains mean bout length for measured time - 
			    $meanbouts{$group . "\t" . $d[0] . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]} = $a[8];
			    
			    ###how many times do I see this grouping - i.e. sleep day 1 and sleep day 2
			    $counts{$group . "\t" . $d[0] . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]} = 1;
			    
			}elsif(exists($data{$group . "\t" . $d[0] . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]})){
			    
			    if($data{$group . "\t" . $d[0] . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]} !~ m/NA/){
		        
				$data{$group . "\t" . $d[0] . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]} = $a[6] + $data{$group . "\t" . $d[0] . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]};

				$bouts{$group . "\t" . $d[0] . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]} = $a[7] + $bouts{$group . "\t" . $d[0] . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]};
				
				$meanbouts{$group . "\t" . $d[0] . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]} = $a[8] + $meanbouts{$group . "\t" . $d[0] . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]};
				
				$counts{$group . "\t" . $d[0] . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]}++;
			    }
			}
		    }else{		
			#	print $line, "\n";
		    }
		}
		#this is calculating the total time for that portion of the experiment
		if(!(exists($time{$group . "\t" . $d[0] . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]}))){
		    
		    $time{$group . "\t" . $d[0] . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]} = $a[6];
		    
		}elsif(exists($time{$group . "\t" . $d[0] . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]})){
		    
		    $time{$group . "\t" . $d[0] . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]} = $a[6] + $time{$group . "\t" . $d[0] . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]};
		    
		}
		
	    }elsif($a[1] =~ m/Movement/){ #### Do I need to change this???? - to deal with NAs
		
		if($a[8] !~ m/NA/){
		    my @t = split(/,/, $a[9]);
		    #	print scalar(@t), "\t", join(",", @t), "\n";
		    
		    if(!(exists($time{$group . "\t" . $d[0] . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]}))){
			
			$time{$group . "\t" . $d[0] . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]} = scalar(@t);
			
		    }elsif(exists($time{$group . "\t" . $d[0] . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]})){
			
			$time{$group . "\t" . $d[0] . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]} = $time{$group . "\t" . $d[0] . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]} + scalar(@t);
			#	    print "adding \n";
			
		    }
		    
		    
		    if(!(exists($move{$group . "\t" . $d[0] . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]}))){
			
			$move{$group . "\t" . $d[0] . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]} = $a[8];
			$movecount{$group . "\t" . $d[0] . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]} = 1;
			
		    }elsif(exists($move{$group . "\t" . $d[0] . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]})){
			
			$move{$group . "\t" . $d[0] . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]} = $a[8] + $move{$group . "\t" . $d[0] . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]};
			$movecount{$group . "\t" . $d[0] . "\t" . $a[2] . "\t" . $id . "\t" . $a[3] . "\t" . $a[4] . "\t" . $a[5]}++;
		    }
		}else{
		    #	print $line, "\n";
		}
	    }
	}elsif(exists($remove{$d[0] . "\t" . $a[3]})){
	  #  print $line, "\n";
	}
    }
    close A;
}

my @sortnum = sort {$a <=> $b} @num;

foreach my $date (@date){
    
    my $output = $date . ".total_sleep";
    unlink(qq{$output});
    
    print $output, "\n";
    
    open(B, ">>$output");
    print B "Genotype\tPop\tNum\tSex\tTemp";
    
    foreach my $group (@group){
	print B "\t", $group, "_percent", "\t", $group, "_boutNum", "\t", $group, "_meanBout", "\t", $group, "_meanMove";
    }
    print B "\n";
    
    my $output2 = $date . ".percent_day_sleep";
    unlink(qq{$output2});
    
    open(C, ">>$output2");
    print C "Genotype\tPop\tNum\tSex\tTemp\tSleepDay\tSleepNight\tSleepDayPercent\tStarveDay\tStarveNight\tStarveDayPercent\n";
    
    ##Sex pop geno temp num
    
    foreach my $id (@id){ #this is the genotype
	
	my $pop = $id;
	$pop =~ s/\d+//;
	
	foreach my $num (@sortnum){ #individual number
	    
	    my $nacount = 0;
	    
	    foreach my $group (@group){ #which group
		
		if(!(exists($data{$group . "\t" . $date . "\t" . $sex{$num} . "\t" . $pop . "\t" . $id . "\t" . $temp{$date} . "\t" . $num}))){
		    
		    $nacount++;		    
		}
	    }
	    
	    if($nacount == 0){
		
		print B $id, "\t", $pop, "\t", $num, "\t", $sex{$num}, "\t", $temp{$date};
		
		print C $id, "\t", $pop, "\t", $num, "\t", $sex{$num}, "\t", $temp{$date}, "\t";
		
		foreach my $group (@group){ #which group
		    
		    print B "\t", sprintf("%.3f",($data{$group . "\t" . $date . "\t" . $sex{$num} . "\t" . $pop . "\t" . $id . "\t" . $temp{$date} . "\t" . $num} / $time{$group . "\t" . $date . "\t" . $sex{$num} . "\t" . $pop . "\t" . $id . "\t" . $temp{$date} . "\t" . $num})), "\t", 
		    
		    sprintf("%.1f",($bouts{$group . "\t" . $date . "\t" . $sex{$num} . "\t" . $pop . "\t" . $id . "\t" . $temp{$date} . "\t" . $num} / $counts{$group . "\t" . $date . "\t" . $sex{$num} . "\t" . $pop . "\t" . $id . "\t" . $temp{$date} . "\t" . $num})), "\t",  
		
		    sprintf("%.3f",($meanbouts{$group . "\t" . $date . "\t" . $sex{$num} . "\t" . $pop . "\t" . $id . "\t" . $temp{$date} . "\t" . $num} / $counts{$group . "\t" . $date . "\t" . $sex{$num} . "\t" . $pop . "\t" . $id . "\t" . $temp{$date} . "\t" . $num})), "\t",
		 
		    sprintf("%.3f",($move{$group . "\t" . $date . "\t" . $sex{$num} . "\t" . $pop . "\t" . $id . "\t" . $temp{$date} . "\t" . $num} / $movecount{$group . "\t" . $date . "\t" . $sex{$num} . "\t" . $pop . "\t" . $id . "\t" . $temp{$date} . "\t" . $num})),
		}
		print B "\n";
		
		
		print C $data{"Sleep_Day" . "\t" . $date . "\t" . $sex{$num} . "\t" . $pop . "\t" . $id . "\t" . $temp{$date} . "\t" . $num}, "\t", 
		$data{"Sleep_Night" . "\t" . $date . "\t" . $sex{$num} . "\t" . $pop . "\t" . $id . "\t" . $temp{$date} . "\t" . $num}, "\t", 
		sprintf("%.3f",($data{"Sleep_Day" . "\t" . $date . "\t" . $sex{$num} . "\t" . $pop . "\t" . $id . "\t" . $temp{$date} . "\t" . $num} / ($data{"Sleep_Day" . "\t" . $date . "\t" . $sex{$num} . "\t" . $pop . "\t" . $id . "\t" . $temp{$date} . "\t" . $num} + $data{"Sleep_Night" . "\t" . $date . "\t" . $sex{$num} . "\t" . $pop . "\t" . $id . "\t" . $temp{$date} . "\t" . $num}))), "\t",
		 
		$data{"Starve_Day" . "\t" . $date . "\t" . $sex{$num} . "\t" . $pop . "\t" . $id . "\t" . $temp{$date} . "\t" . $num}, "\t", 
		$data{"Starve_Night" . "\t" . $date . "\t" . $sex{$num} . "\t" . $pop . "\t" . $id . "\t" . $temp{$date} . "\t" . $num}, "\t", 
		sprintf("%.3f",($data{"Starve_Day" . "\t" . $date . "\t" . $sex{$num} . "\t" . $pop . "\t" . $id . "\t" . $temp{$date} . "\t" . $num} / ($data{"Starve_Day" . "\t" . $date . "\t" . $sex{$num} . "\t" . $pop . "\t" . $id . "\t" . $temp{$date} . "\t" . $num} + $data{"Starve_Night" . "\t" . $date . "\t" . $sex{$num} . "\t" . $pop . "\t" . $id . "\t" . $temp{$date} . "\t" . $num}))), "\n"; 
		
	    }
	}
    }
    close B;
    close C;
}


