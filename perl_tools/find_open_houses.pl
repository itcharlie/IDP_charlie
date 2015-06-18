#!/usr/bin/perl

use strict;

use HTML::TokeParser;
use LWP::UserAgent;
use Data::Dumper;


my $ua = LWP::UserAgent->new();

my $response = $ua->get("http://www.trulia.com/for_sale/Bronx,NY/p_oh/2p_beds/0-350000_price/1000p_sqft");

my %open_houses;

my $found_listing_price = 0;
my $found_listing;
if ($response->is_success) {
	my $stream = HTML::TokeParser->new( \$response->decoded_content )
		|| die "Couldn't read html stream  $!\n";

	my $counter = 0 ;
	while ( my $token = $stream->get_token() ) {
		

		if ( defined($token->[0]) ) {
			if ( ( $token->[0] eq "S")
				and ( $token->[1] eq 'span')
			) {
				if( $token->[2]{'itemprop'} eq 'name' ){
					$open_houses{$counter}{name} =  $token->[2]{'content'};
					next;
				}
			}

			if ( ( $token->[0] eq "S" ) 
				and ( $token->[1] eq 'meta')  
			) { 
				if( $token->[2]{'itemprop'} eq 'startDate' ){
					$open_houses{$counter}{start_date} =  $token->[2]{'content'};
					next;
				} elsif ( $token->[2]{'itemprop'} eq 'endDate' ) {
					$open_houses{$counter}{end_date} = $token->[2]{'content'};
					next;
				}
			};
		};

		if ( ( $found_listing_price == 1) 
			and ($token->[0] eq "T")
		) {

			my $listing_price = $token->[1];
			$listing_price =~ s/\s//g;
			$open_houses{$counter}{list_price} = $listing_price;
			$found_listing_price =0;
			$counter++;
		}

		if ( ( $token->[0] eq "S")
			and ( $token->[1] eq 'strong')
			and ( $token->[2]{'class'} =~ /listingPrice\s$/ )
		) {
			$found_listing_price =1;
		}

       };
	print Dumper \%open_houses;
}
else {
    die $response->status_line;
}

