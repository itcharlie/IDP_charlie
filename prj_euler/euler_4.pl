use strict;
use Data::Dumper;

#
#A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.
#Find the largest palindrome made from the product of two 3-digit numbers.

# I will first use the example to detemine how the numbers are found.

my @list_two = ( 100 ... 999 );
my %result;
my @palindrome;

foreach my $number (@list_two) {
  foreach my $number2 (@list_two)  {
     
     my $value = $number . "," . $number2;
     $result{$number *$number2}= $value;
  }
  
}


foreach my $key  ( keys (%result) )  {
  is_palindrome($key);

}



sub is_palindrome {
  my $term = shift;
  if ( $term - ( reverse($term) ) == 0 ) {
     push( @palindrome , $term );
  }
  
}
my @sorted = sort {$b <=> $a} @palindrome;

print $sorted[0] ." => " . $result{$sorted[0]} . "\n";

