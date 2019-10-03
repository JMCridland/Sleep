#!perl -w

use strict;


#I need to read in Didem's monitor data - which I used the DAM program to sort into files based on date (there are 4 folders) 

my $indir = shift(@ARGV) or die; #this is the DateCtMoo#.txt files in a particular date directory
my $ids = shift(@ARGV) or die; #this file has the data about which fly genotype is on which monitor
my $times = shift(@ARGV) or die;
my $output = shift(@ARGV) or die; #stores data
unlink(qq{$output});
my $output2 = shift(@ARGV) or die; #records monitors that are off when they should be on
unlink(qq{$output2});

#I need to know  
#A) number of sleep bouts - 5 min of inactivity
#B) duration of sleep bouts
#C) number of movements per minute when awake - includes zeros for less than 5 min intervals
#D) sleep bouts per daytime period
#E) sleep bouts per nighttime period
#F) Total amount of time spent asleep

my %ids = ();
my %startday = ();
my %starttime = ();
my %endday = ();
my %endtime = ();
my %times = ();
my @times= ();

open(T, "<$times");
while(my $line4 = <T>){
    chomp $line4;
    my @t = split(/\s+/, $line4);
    $times{$t[0]} = $t[0];
    push(@times, $t[0]);
    $startday{$t[0]} = $t[1];
    $starttime{$t[0]} = $t[2];
    $endday{$t[0]} = $t[3];
    $endtime{$t[0]} = $t[4];
}
close T;

my @ids = ();

open(A, "<$ids");
while(my $line = <A>){
    chomp $line;
    my @a = split(/\t/, $line);
    if($line !~ m/Temp/){
	
	$ids{$a[2]} = $a[0] . "\t" . $a[1];
	push(@ids, $a[2]);
    }
}
close A;

###output files will be for each individual - I will have sums for each of the numbers I want

opendir DIR, "$indir";
my @files = grep {/\.txt/} readdir DIR;
closedir DIR;


foreach my $kt (@times){
    
    my $startday = $startday{$kt};
    my $starttime = $starttime{$kt};
    my $endday = $endday{$kt};
    my $endtime = $endtime{$kt};  

    my %problems = (); #record files with problems
    
    my %sleepbout = (); #sleeping bouts - normal 
    my %move = ();
    my %all = ();
    
    foreach my $file (@files){
	print $file, "\n";
	my @f = split(/CtM/, $file);
	$f[1] =~ s/^0+//;
	$f[1] =~ s/\.txt//;
	#   
	if(exists($ids{$f[1]})){
	 #   print $f[1], "\n";

	    OUTER:for(my $i = 10; $i < 42; $i++){ #for each individual
		my $tmp = 0; #temporary number of zeros I've seen since last non zero number	    
		my $start = 0;
		my $end = 0;
	#	print $i, "\n";

		$all{$ids{$f[1]} . "\t" . $i} = 1;
		
		open(B, "<$file");
		
	      LOOP:while(my $line2 = <B>){
		  chomp $line2;
		  chop $line2;
		  my @b = split(/\t/, $line2);
		         
		  $b[1] =~ s/\s+/\-/go;
		  #	print $b[1], "\n";

		  if(($start == 1) and ($end == 0) and ($b[3] == 51)){#here I am checking for lack of recording
		      
		      if(!(exists($problems{$kt . "\t" . $ids{$f[1]} . "\t" . $i}))){
			  $problems{$kt . "\t" . $ids{$f[1]} . "\t" . $i} = 1;
		      }elsif(exists($problems{$kt . "\t" . $ids{$f[1]} . "\t" . $i})){
			  $problems{$kt . "\t" . $ids{$f[1]} . "\t" . $i}++;
		      }
		  }
		  		  
		  if(($start == 0) and ($end == 0)){ #haven't seen start or stop
		      
		      if(($b[1] eq $startday) and ($b[2] eq $starttime)){
		#	  print "Starting \t", $kt, "\t", $ids{$f[1]}, "\t", $i, "\t", "\n";
			  $tmp = 0;
			  $start = 1; #found start date / time - start recording
			  
			  if($b[3] == 1){
			      if($b[$i] == 0){ # could be a sleep bout or just no movement				  
				  $tmp++;
			#	  print "Starting Tmp\t", $tmp, "\n";
			      }elsif($b[$i] > 0){ #moving - but this is the first recorded interval
				  
				  push(@{$move{$ids{$f[1]} . "\t" . $i}}, $b[$i]); #add the current movement
				  $tmp = 0; #make sure tmp is reset to zero
			      }
			  }
			  
		      }
		      next LOOP;
		      
		  }elsif(($start == 1) and ($end == 0)){
		      
		      if(($b[1] eq $endday) and ($b[2] eq $endtime)){ #this is the end of the sleep period-  record here
			  
		#	  print $line2, "\n";
		#	  print "Found the end\n";
		#	  print "Ending\t", $kt, "\t", $ids{$f[1]}, "\t", $i, "\t", "\n";
			  
			  $end = 1; #found start date / time - start recording
			  
			  #	print $b[1], "\t", $b[2], "\t", "sleeping End\n";
			  if($b[3] == 1){ #all is well - add the recording
			      if($b[$i] == 0){ # record the last point in the time frame - then store data
				 
				  $tmp++;

				  if(($tmp > 0) and ( $tmp < 5)){ #no movement immediately before, but not a sleep bout
				      
				      for(my $j = 1; $j <= $tmp; $j++){
					  push(@{$move{$ids{$f[1]} . "\t" . $i}}, "0"); #I need to add that many zeros
				      }
				      $tmp = 0; #reset tmp
				      
				  }elsif($tmp >= 5){ # a sleep bout - record length
				      
				      push(@{$sleepbout{$ids{$f[1]} . "\t" . $i}}, $tmp); #tmp is length of sleep bout				
				      $tmp = 0; #reset tmp
				      
				  }

				  #	  print "Ending Tmp\t", $tmp, "\n";	
				  $tmp = 0; #reset tmp
				  
			      }elsif($b[$i] > 0){ #moving - but this is the first recorded interval
				  
				  if(($tmp > 0) and ( $tmp < 5)){ #no movement immediately before, but not a sleep bout
				      
				      for(my $j = 1; $j <= $tmp; $j++){
					  push(@{$move{$ids{$f[1]} . "\t" . $i}}, "0"); #I need to add that many zeros
				      }
				      $tmp = 0; #reset tmp
				      
				  }elsif($tmp >= 5){ # a sleep bout - record length
				      
				      push(@{$sleepbout{$ids{$f[1]} . "\t" . $i}}, $tmp); #tmp is length of sleep bout				
				      $tmp = 0; #reset tmp
				      
				  }
				  
				  push(@{$move{$ids{$f[1]} . "\t" . $i}}, $b[$i]); #add the current movement
				  $tmp = 0;
			      }
			  }elsif($b[3] != 1){
			      #last time is not recording, but I need to store any data before that point
			      
			      if(($tmp > 0) and ( $tmp < 5)){ #no movement immediately before, but not a sleep bout
				      
				  for(my $j = 1; $j <= $tmp; $j++){
				      push(@{$move{$ids{$f[1]} . "\t" . $i}}, "0"); #I need to add that many zeros
				  }
				  $tmp = 0; #reset tmp
				  
			      }elsif($tmp >= 5){ # a sleep bout - record length
				  
				  push(@{$sleepbout{$ids{$f[1]} . "\t" . $i}}, $tmp); #tmp is length of sleep bout				
				  $tmp = 0; #reset tmp				  
			      }
			  }
		#	  print "Go to outer loop end\n";
			  last LOOP;
			  
		      }else{ #still sleeping time
		#	  print "Still counting\n";
			  #	  print $line2, "\n";
			  if($b[3] == 1){ #only store data if monitor is recording
			      if($b[$i] == 0){ # could be a sleep bout or just no movement
				  
				  $tmp++;	
				  next LOOP;
				  
			      }elsif($b[$i] > 0){ #moving - check to see if end of sleep bout
				  
				  if($tmp == 0){  #movement in the previous minute
				      #placeholder for now
				      
				  }elsif(($tmp > 0) and ( $tmp < 5)){ #no movement immediately before, but not a sleep bout
				      
				      for(my $j = 1; $j <= $tmp; $j++){
					  push(@{$move{$ids{$f[1]} . "\t" . $i}}, "0"); #I need to add that many zeros
				      }
				      $tmp = 0; #reset tmp
				      
				  }elsif($tmp >= 5){ # a sleep bout - record length
				      
				      push(@{$sleepbout{$ids{$f[1]} . "\t" . $i}}, $tmp); #tmp is length of sleep bout				
				      $tmp = 0; #reset tmp
				      
				  }			   
				  
				  push(@{$move{$ids{$f[1]} . "\t" . $i}}, $b[$i]); #add the current movement
				  next LOOP;
			      }
			  }
		      }							
		  }
	      }    	  
	    }
	}
    }
    ### now print out data    
    open(C, ">>$output");
    
    while((my $k, my $v) = each(%all)){
	
	my @x = split(/\t/, $k);
	
	my $sex = 0;
	
	if($x[2] <= 25){
	    $sex = "M";
	}else{
	    $sex = "F";
	}
	
	####Movement
	print C $kt, "\t", "Movement", "\t", $sex, "\t", $k, "\t";
	
	my $mcount = 0; #the sum of movements recorded
	my $msum = 0;
	
	foreach my $m (@{$move{$k}}){
	    
	    $mcount++;
	    $msum = $m + $msum;
	}
	
	print C $msum, "\t", $mcount, "\t";
	
	if($mcount > 0){
	    print C ($msum / $mcount), "\t";
	}else{
	    print C "NA", "\t", "NA", "\t";
	}
	
	print C join(",", @{$move{$k}}), "\n";
	
	####Sleep
	print C $kt, "\t", "Sleep", "\t", $sex, "\t", $k, "\t";
	
	my $scount = 0; #the sum of movements recorded
	my $ssum = 0;
	
	foreach my $s (@{$sleepbout{$k}}){
	    
	    $scount++;
	    $ssum = $s + $ssum;
	}
	
	print C $ssum, "\t", $scount, "\t";
	
	if($scount > 0){
	    print C ($ssum / $scount), "\t";
	}else{
	    print C "NA", "\t", "NA", "\t";
	}
	
	print C join(",", @{$sleepbout{$k}}), "\n";
	
    }
    close C;

    open(D, ">>$output2");
    
    while((my $k2, my $v2 ) = each(%problems)){
	
	print D $k2, "\t", $v2, "\n";
    }
    close D;
}
