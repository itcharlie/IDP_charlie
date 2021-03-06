use strict;
use Data::Dumper;
use bigint;

# Each new term in the Fibonacci sequence is generated by adding the previous 
# two terms. By starting with 1 and 2, the first 10 terms will be:
# 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...
# By considering the terms in the Fibonacci sequence whose values do not exceed
# four million, find the sum of the even-valued terms.

# rewrite with recursion

my $term_one = 1;
my $term_two = 1;
my $new_term;
my $sum_term = 0;

while ($new_term < 4000000 ) {
     if ( $term_one >= 1) {
       $new_term = $term_one + $term_two;
       $term_two = $term_one;
       $term_one = $new_term;
        
      
          if ($new_term % 2 == 0 ) {
             # print "new term = : " . $new_term ."\n";
              $sum_term += $new_term;
          } 
      } 

}

print $sum_term  . "\n";


