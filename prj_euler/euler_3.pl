use strict;
use Data::Dumper;

#  Euler problem #3:
#  The prime factors of 13195 are 5, 7, 13 and 29.
#  What is the largest prime factor of the number 600851475143 ?
# Definition as stated from this site ( http://www.mathsisfun.com/prime_numbers.html )# Prime Numbers can be divided evenly only by 1 or itself.
#  And it must be a whole number greater than 1. 

#  My approach to this problem is to list a few prime numbers 
#  and using this list I will attempt to determine the prime numbers 
#   for  600851475143
my @prime_num;
my $total = 600851475143;
my @prime_factors;

for  my $term ( 2 ... 1000) {
     is_prime($term);
}

print Dumper(\@prime_factors);
#print Dumper(\@prime_num);
# The approach to determine prime factors for  600851475143
# is to divide the number by the first prime number evenly and if that happens
# assign that number to the list of prime numbers. The remainder of the calculation 
# is then used to determine the next prime number.

sub prime_factors {
    my $num  = shift;
    my $tmp_num =  $total;
    my $result;
    
      for my $factor ( @prime_num) {
	CALC:   $result = $tmp_num / $factor ;
	  
	  if ( $result !~ /\D/) {
	           push( @prime_factors,  $factor );
	           $tmp_num = $result;
	           redo CALC;
          } else {
           	  next;
          }
		        
	             }	
	}
sub is_prime{
	my $num = shift;
	
	# Check if the number is not 2 and can be divided by 2
	
	 if ( ( ($num/2) !~ /\D/ ) and $num != 2 ) {
	  next;
	 # Check if the number is not  3 and can be divided by 3 
	 } elsif  (  (($num /3) !~ /\D/ ) and $num !=3  ) {
	  next;
	 # Check if the number is not 5 and can it be divided by 5 
	 } elsif ( ( ($num /5) !~ /\D/) and $num != 5 ) {
           next;	  
	  } else {
		  push( @prime_num  , $num) ;
         };
	}

