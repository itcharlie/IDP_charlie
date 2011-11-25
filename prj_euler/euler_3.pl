use strict;
use Data::Dumper;
use bignum;

# Not solved Yet:

#  Euler problem #3:
#  The prime factors of 13195 are 5, 7, 13 and 29.
#  What is the largest prime factor of the number 600851475143 ?
# Definition as stated from this site ( http://www.mathsisfun.com/prime_numbers.html )# Prime Numbers can be divided evenly only by 1 or itself.
#  And it must be a whole number greater than 1.

#  My approach to this problem is to list a few prime numbers
#  and using this list I will attempt to determine the prime numbers
#   for  600851475143

my @prime_num;
my @prime_factors;
my $total     = 600851475143;
my $three_quarters  = int(($total/4)*3);
my $half = int($total/2);
my $term = $three_quarters;
print $three_quarters . " This is three quarters\n";

while(1) {
    
    if ( $term == $half ) { 
        die "Unable to find prime factor\n $!";
    } else {
    
      print $term . "\n";
      my $prime = is_prime($term);
    
      if ($prime eq "ok") {
          prime_factors($term);
      }
       $term--;
    }

}


print Dumper( \@prime_factors );

# print Dumper( \@prime_factors );
# print Dumper(\@prime_num);



sub prime_factors {
    my $num = shift;
 
    next if $num == 0;
    if ( ( $total % $num ) == 0 ) {
        print  $num . "\n";
        exit;
        
    }
}

sub is_prime {
    my $num = shift;

    # Check if the number is not 2 and can be divided by 2

    if ( ( ( $num % 2 )== 0 ) and $num != 2 ) {
        next;

        # Check if the number is not  3 and can be divided by 3
    }
    elsif ( ( ( $num % 3 ) == 0 ) and $num != 3 ) {
        next;

        # Check if the number is not 5 and can it be divided by 5
    }
    elsif ( ( ( $num % 5 ) == 0 ) and $num != 5 ) {
        next;
    }
    else {
       return "ok";
    }
}
