#!perl -w

use strict;

my $indir = shift(@ARGV) or die; #this is the DateCtMoo#.txt files in a particular date directory
my $ids = shift(@ARGV) or die; #this file has the data about which fly genotype is on which monitor
my $startday = shift(@ARGV);
my $starttime = shift(@ARGV);
my $endday = shift(@ARGV);
my $endtime = shift(@ARGV);
my $info = shift(@ARGV) or die;
my $itr = shift(@ARGV) or die; #size of bin in minutes = using 15 here
my $output = shift(@ARGV) or die;
unlink(qq{$output});

my %ids = ();  #this tells me which monitor is which genotype
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

opendir DIR, "$indir";
my @files = grep {/\.txt/} readdir DIR;
closedir DIR;

my %data = ();
my %times = ();

open(B, ">>$output");
print B "Date\tTime\tGenotype\tTemp\tGroup";
for(my $i = 10; $i <= 25; $i++){
    print B "\tM", $i;
}
for(my $j = 26; $j < 42; $j++){
    print B "\tF", $j;
}
print B "\n";
foreach my $file (@files){
    
    print $file, "\n";
    my @f = split(/CtM/, $file);
    $f[1] =~ s/^0+//;
    $f[1] =~ s/\.txt//;

    my $count = 1; #initialize the count for incriments of $itr minutes
    my $start = 0;
    my $order = 0;
    my $current = "";
    
    if(exists($ids{$f[1]})){
	print $f[1], "\n";
	my $start = 0;
	my $end = 0;

	$file = $indir . $file;
	
	open(F, "<$file");
      LOOP:while(my $line = <F>){
	  chomp $line;
	  chop $line;
	  
	  my @b = split(/\t/, $line);

	  $b[1] =~ s/\s+/\-/go;
	  
	  if($start == 0){ #haven't seen start or stop
	      
	      if(($b[1] eq $startday) and ($b[2] eq $starttime)){  #the beginning
		  $start = 1;
		  if($count == 1){
		      
		      $times{$order} = $b[1] . "\t" . $b[2];##save the start times per interval
		      $current =  $times{$order};
		      
		      for(my $i = 10; $i < 42; $i++){ #for each individual
			  
			  $data{$current . "\t" . $ids{$f[1]} . "\t" . $i} = $b[$i]; #initialized
		      }		      
		      $count++;
		      next LOOP;
		  }else{
		      print "Count is off\n";
		      die;
		  }		  
	      }
	      next LOOP;
	  }elsif($start == 1){

	      if(($b[1] eq $endday) and ($b[2] eq $endtime)){
		  
		  if($count == $itr){
		      for(my $i = 10; $i < 42; $i++){ #for each individual
		      
			  $data{$current . "\t" . $ids{$f[1]} . "\t" . $i} = $b[$i] + $data{$current . "\t" . $ids{$f[1]} . "\t" . $i}; #adding
		      }
		  }else{
		      #not a mulitple of the itr - delete it
		  }
		  
		 # print "end\n";
		  last LOOP;

	      }else{
		  
		  if($count == 1){  #new one
		    #  print $b[1], "\t", $b[2], "\n";

		      $times{$order} = $b[1] . "\t" . $b[2];##new time to keep track of
		      $current = $times{$order};
		       for(my $i = 10; $i < 42; $i++){ #for each individual
		      
			   $data{$current . "\t" . $ids{$f[1]} . "\t" . $i} = $b[$i]; #initialized
		       }
		      $count++;
		      next LOOP;
		      
		  }elsif(($count > 1) and ($count < $itr)){  #add to ongoing

		       for(my $i = 10; $i < 42; $i++){ #for each individual
		      
			   $data{$current . "\t" . $ids{$f[1]} . "\t" . $i} = $b[$i] + $data{$current . "\t" . $ids{$f[1]} . "\t" . $i}; #adding		      
		       }
		       $count++;
		      next LOOP;
		  }elsif($count == $itr){  #print at the end

		       for(my $i = 10; $i < 42; $i++){ #for each individual
		      
			   $data{$current . "\t" . $ids{$f[1]} . "\t" . $i} = $b[$i] + $data{$current . "\t" . $ids{$f[1]} . "\t" . $i}; #adding		      
		       }
		       $order++;		       
		      $count = 1;
		      next LOOP;
		  }
	      }
	  }
      }
	close F;
	
	
	###Now print out to the file

	for(my $x = 0; $x < $order; $x++){
	    
	    print B $times{$x}, "\t", $ids{$f[1]}, "\t", $info;
	    
	    for(my $j = 10; $j < 42; $j++){
		print B "\t", $data{$times{$x} . "\t" . $ids{$f[1]} . "\t" . $j};
	    }
	    print B "\n";
	}
    }
}


#while((my $k, my $v) = each(%data)){

#    print $k, "\t", $v, "\n";
#}
