use strict;
use Data::Dumper;

print"
# 
# If we list all the natural numbers below 10 that are multiples of 3 or 5, we 
# get 3, 5, 6 and 9. The sum of these multiples is 23. Find the sum of all the 
# multiples of 3 or 5 below 1000.
# \n\n";


my $sum = '0';

for my $natural ( 1 ... 999 ) {
   if ($natural % 3 == 0 ) {
      $sum += $natural;
   } elsif ( $natural =~ /0$|5$/ ) {
      $sum += $natural;
   };
   
}

print "The total of the multiples of 3 and 5 is: " . $sum . "\n\n";





# this is the old way I solved this problem.
__END__
my @list;
my $sum; 
# Make another version with % operator;
#
#  Loop thru all numbers from 1 - 1000
#  and divide them by 5 and 3. 

for my $natural ( 1 .. 999 ) { 

# loop to verify that it is working 
# by comparing sum with sum stated 
# in the problem (23)
# for my $natural ( 1 ... 9 ) { 

  my $three = $natural / 3; 
  my $five = $natural / 5;

# Check if the quotient is an natural number 
# by using a regex match \D (non-digit) 

  if  ( $three  !~ /\D/ ) {
     push(@list, $natural); 
  } elsif  ( $five !~ /\D/ ) {
     push(@list, $natural);
  };

}

#print Dumper( \@list );

$sum += $_ for @list;

print $sum . "\n";
