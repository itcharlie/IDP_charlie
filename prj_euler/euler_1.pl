use strict;
use Data::Dumper;

print"
# 
# If we list all the natural numbers below 10 that are multiples of 3 or 5, we 
# get 3, 5, 6 and 9. The sum of these multiples is 23. Find the sum of all the 
# multiples of 3 or 5 below 1000.
# \n\n";


my $sum = '0';

for my $natural ( 1 .. 999 ) {
   if ($natural % 3 == 0 ) {
      $sum += $natural;
   } elsif ( $natural =~ /0$|5$/ ) {
      $sum += $natural;
   };
   
}

print "The total of the multiples of 3 and 5 is: " . $sum . "\n\n";
