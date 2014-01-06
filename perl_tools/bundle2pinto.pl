#!/usr/bin/env perl 

# This script will parse a cpan bundle file and create a pinto repository
# with modules listed in the bundle file. 

use strict; 
use Data::Dumper;
use LWP::Simple;
use JSON;
use Getopt::Long;
use Pod::Usage;

my $TIME = time();
my $REPO = "bundle_" . $TIME;

my ($dist_file, $cpan_bundle, $help, $man) = (0,0,0,0);

GetOptions ( "dist_file=s"   => \$dist_file,
	     "cpan_bundle=s" => \$cpan_bundle,
	     man => \$man,
	     'help|?' => \$help )
or pod2usage(2);

start_autobundle($cpan_bundle) if $cpan_bundle;
start_dist_file($dist_file) if $dist_file;
pod2usage(1) if $help;
pod2usage(-exitval => 0, -verbose => 2) if $man;
pod2usage("$0: No file given.")  if (@ARGV == 0);


sub start_autobundle {
	
	create_pinto_repo();

	my $file = shift;
	print "Parsing Autobundle File\n";
	
	open( my $fh , "<", $file ) 
		or die "Unable to open $file \n $!";
	
	
	# Parse bundle file and determine distribution file url for each module version
	my %modules =();
	my %undef_versions = ();
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
		
		# skip functions 
		next if $fields[0] =~ /^[a-z]/;
		# skip undef module versions 
		if ( $fields[1] == "undef") {
			$undef_versions{$fields[0]} = 1;
			next;	
	        }
		
		$modules{$fields[0]}{'VERSION'} = $fields[1];
	}
	print "Determining Distribution Files\n";
	
	my %dist_archives =();
	
	for my $mod  ( keys %modules ) {
		# Store the archive url in the hash for the modules that do have versions defined
		my $archive_url = dist_archive_url( $mod, $modules{$mod}{'VERSION'} ) ;
		next if ( ! $archive_url );
		$dist_archives{$archive_url} = 1;
	}
	my @sorted_dist_archives = sort( keys( \%dist_archives ) );

	print "Generating distribution list file : dist_file_$TIME\n";
 	open (my $fh_dl , ">", "dist_file_" . $TIME)
		or die "Unable to create a distribution list file. $!";
	print $fh_dl join("\n", @sorted_dist_archives );
	
	print "Adding distribution to $REPO\n\n";
	for my $archive_url ( @sorted_dist_archives ) {
	
		add_to_repo($archive_url);
	}
}


sub start_dist_file {
	
	create_pinto_repo();

	my $file = shift;
	my %dist_archives =();
	print "Parsing Distribution File\n";
	
	open( my $fh , "<", $file ) 
		or die "Unable to open $file \n $!";
	
	while(my $archive_url = <$fh>) {
		$archive_url =~ s/\r\n|\r|\n//g;
		print $archive_url . "\n";
		$dist_archives{$archive_url} = 1;
	}	
	
	print "Adding distributions to $REPO\n\n";
	my @sorted_dist_archives = sort( keys( \%dist_archives ) );

	for my $archive_url ( @sorted_dist_archives ) {
	
		add_to_repo($archive_url);
	}
}

sub create_pinto_repo {
	# Create a Pinto repo 
	
	system( "pinto -r ~/" . $REPO . " init") ==0 
		or die "Unable to create pinto repo : $REPO $!";
	print "Pinto Repo ~/$REPO created\n";
	return 1;
}

sub add_to_repo {
	my $archive_url = shift;

	print "Pulling $archive_url to repo\n";
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

=pod

=head1 bundle2pinto.pl

bundle2pinto.pl - Parse a CPAN autobundle file and create a Pinto repository.

=head1 SYNOPSIS

bundle2pinto.pl [options] [file]

Options:

  -help         Prints a brief description of this script.

  -dist_file    File containing a list of distribution archive urls.

  -cpan_bundle  CPAN Autobundle file.

=head1 OPTIONS

=over 8

=item B<-help>

Prints a brief description of this script.

=item B<-cpan_bundle>

Allows you to pass in a filename of the cpan autobundle file. This file is generated from a cpan client by entering the autobundle command in the cpan shell.

=item B<-dist_file>

Allows you to pass in a file containing a list of distribution urls delimited by newlines. This file is also generated from a previous run of the same script using the -cpan-bundle option.

=back

=head1 DESCRIPTION

B<bundle2pinto.pl> will create a pinto repository with a list of distributions that is determined from a cpan autobundle file.

=cut

