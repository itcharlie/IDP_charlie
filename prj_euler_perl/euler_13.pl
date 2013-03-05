use strict;
use bigint;
use POSIX;

# sum.txt contains the list of numbers to be added.

open( my $fh , "<", "sum.txt" )
or die "unable to open $!";

my $total_num =0;
while(my $line = <$fh>) {
        my @char_line = split('',$line);
        @char_line = splice(@char_line,0,25);
        my $num = join("", @char_line);
        $total_num = $total_num + ceil($num);
}

print $total_num;
