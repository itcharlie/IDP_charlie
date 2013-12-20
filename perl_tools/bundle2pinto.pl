#!/usr/bin/env perl 

# This script will parse a cpan bundle file and create a pinto repository
# with modules listed in the bundle file. 

use strict; 
use Data::Dumper;

my $file = $ARGV[0];

open( my $fh , "<", $file ) 
	or die "Unable to open $file \n $!";


# Parse bundle file and determine distribution file url for each module version
my %modules =();

my $head_cont = 0;

while ( my $line  = <$fh>) {
	
	if ( $line =~ /^\=head1\sCONTENTS/ ) {
		$head_cont = 1;
		next;		
	}
	
	next if ( $head_cont == 0 || $line =~ /^$/);
	last if ( $head_cont && $line =~ /^\=head1/ );
	
	$line =~ s/ +/ /g;
	my @fields =  split( ' ', $line);
	
	$modules{$fields[0]}{'VERSION'} = $fields[1];
	
	# Attempt to search for Module archive via cpan api.
	# Store the archive url in the hash for the modules that do have versions defined
	# Make a list of the undefined modules ( Need to write a script to determine version of these modules )
	# Create a Pinto repo and pass in the ur
}

print Dumper \%modules;
