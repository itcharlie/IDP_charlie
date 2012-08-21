use strict;
use Data::Dumper;

# 2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.
# What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?

my $pos_num = 1;
my @div_num = ( 1 .. 10 );

while(1) {
	my @list = map ( $pos_num % $_, @div_num);
	if ( map( $pos_num % $_, @div_num) == (0) x10 ) {
		print $pos_num;
	}
	$pos_num++;
}