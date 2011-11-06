use strict;
use Data::Dumper;

# Euler problem :
#
# If we list all the natural numbers below 10 that are multiples of 3 or 5, we 
# get 3, 5, 6 and 9. The sum of these multiples is 23. Find the sum of all the 
# multiples of 3 or 5 below 1000.
#

my @list;
my $sum; 

#
#  Loop thru all numbers from 1 - 1000
#  and divide them by 5 and 3. 

for my $natural ( 1 ... 999 ) { 

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
