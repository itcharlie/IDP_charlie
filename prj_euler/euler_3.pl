use strict;
use Data::Dumper;
use bignum;

# Not solved Yet:

#  Euler problem #3:
#  The prime factors of 13195 are 5, 7, 13 and 29.
#  What is the largest prime factor of the number 600851475143 ?
# Definition as stated from this site ( http://www.mathsisfun.com/prime_numbers.html )# Prime Numbers can be divided evenly only by 1 or itself.
#  And it must be a whole number greater than 1.


my $total     = 600851475143;
my $three_quarters  = int(($total/4)*3);
my $half = int($total/2);
my $term = $three_quarters;


while($term >= $half ) {
    
    if ( $term == $half ) { 
        die "Unable to find prime factor\n $!";
    } 
      my $prime = is_prime($term);
      print prime "\n";
      if ($prime eq "ok") {
          prime_factors($term);
      }    
}

continue{
      $term--;
};

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
