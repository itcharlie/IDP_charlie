#!/usr/bin/env perl 

# This script will parse a cpan bundle file and create a pinto repository
# with modules listed in the bundle file. 

use strict; 
use Data::Dumper;
use LWP::Simple;
use JSON;

my $file = $ARGV[0];

open( my $fh , "<", $file ) 
	or die "Unable to open $file \n $!";


# Parse bundle file and determine distribution file url for each module version
my %modules =();
my %undef_versions = ();
my $head_cont = 0;

my $REPO = "bundle_" . time();

# Create a Pinto repo 
system( "pinto -r ~/" . $REPO . " init") ==0 
	or die "Unable to create pinto repo : $REPO $!";

while ( my $line  = <$fh>) {
	
	if ( $line =~ /^\=head1\sCONTENTS/ ) {
		$head_cont = 1;
		next;		
	}
	
	next if ( $head_cont == 0 || $line =~ /^$/);
	last if ( $head_cont && $line =~ /^\=head1/ );
	
	$line =~ s/ +/ /g;
	my @fields =  split( ' ', $line);
	
	# skip functions 
	next if $fields[0] =~ /^[a-z]/;
	# skip undef module versions 
	if ( $fields[1] == "undef") {
		$undef_versions{$fields[0]} = 1;
		next;	
        }
	
	$modules{$fields[0]}{'VERSION'} = $fields[1];
}

my %dist_archives =();

my $count =0;
for my $mod  ( keys %modules ) {
	last if $count > 10;
	# Store the archive url in the hash for the modules that do have versions defined
	my $archive_url = dist_archive_url( $mod, $modules{$mod}{'VERSION'} ) ;
	next if ( ! $archive_url );
	$dist_archives{$archive_url} = 1;
	$count++;
}



for my $archive_url ( keys %dist_archives ) {
	
	add_to_repo($archive_url);
}

sub add_to_repo {
	my $archive_url = shift;
	
	# Pass in the archive url to pinto 		
	my $cmd = "pinto -r ~/" . $REPO . " pull " . $archive_url . " -M";
	
	system( $cmd ) == 0 
		or die "Unable to add $archive_url to repo $!";
	return 1;
}

# Attempt to search for Module archive via cpan api.
sub dist_archive_url {
	
	my ($mod , $version) = @_;

	my $json = JSON->new();
	my $search_cpan = "http://search.cpan.org/api/";
	my $mod_url  = $search_cpan . "module/" . $mod;	
	my $mod_data_json  = get( $mod_url);
	my $mod_data =  $json->decode(  $mod_data_json ) ;

	my $dist = $mod_data->{'distvname'};
	$dist =~ s/\-\d+\.\d+$//; # remove the version number
	my $dist_url = "http://search.cpan.org/api/dist/" . $dist ;
	my $dist_data_json  = get( $dist_url);
	my $dist_data =  $json->decode(  $dist_data_json ) ;

	my $archive_url;	
	for my $release  ( @{$dist_data->{releases}} ) {
		if ( $release->{version} eq $version ) {
			$archive_url = $release->{cpanid} . "/"	. $release->{'archive'};
		}
	}
 	return $archive_url;
}



