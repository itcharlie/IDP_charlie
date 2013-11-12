#!/usr/bin/perl

use strict;
use Data::Dumper;
use Getopt::Long;

my $app_dir;

my %app = ();

GetOptions( "app_dir=s" => \$app_dir )    # numeric
  or die("Error in command line arguments\n");

if ( !-d $app_dir ) {
    die "Directory $app_dir doesn't exist\n";
}
elsif ( !$app_dir =~ /\/$/ ) {
    $app_dir .= "/";
}

# Determine Controllers and routes
$app{'NAME'}        = app_name($app_dir);
$app{'ROUTES'}      = routes_parser($app_dir);
$app{'CONTROLLERS'} = controller_parser($app_dir);
convert_to_dancer(\%app);


# recreate controller and routes in Dancer
# inside home directory
sub convert_to_dancer {
    my $app = shift;
    
    chdir( $ENV{HOME} ) or die ( "Unable to cd to $ENV{HOME} " );
    exec( "dancer -a  $app{NAME}" )  or die ( "Unable to create Dancer $app{NAME} $!" );

}

sub app_name {
	my $app_dir = shift;
	my $config = $app_dir . "config/application.rb";	
	
	open( my $ofh, "<", $config )
      or die "Unable to open $config $!\n";
	while ( <$ofh> ) {
		my $string = $_;
		if ( $string =~ /^module/) {
			$string =~ s/module //g;
			$string =~ s/\r|\n//g;
			return $string;	
		}	
	}

}


sub controller_parser {
    my $app_dir    = shift;
    my $cntrl_path = $app_dir . "app/controllers/";
    my %controllers =();

    opendir( my $dh, $cntrl_path ) || die;

    while ( readdir $dh ) {
        next if ( $_ =~ /\.$/ );
	my $filename = $_;
	
        my $file_path = $cntrl_path . "" . $filename;
	
	my $cntrl_name = $filename;
	$cntrl_name =~ s/\_controller\.rb//g;


        if ( -f $file_path ) {
            open( my $ofh , "<" , $file_path )
                or die "Unable to open $file_path $!\n";
            my $count = 1;
            while(<$ofh>) {
               if ( $_ =~ /def\s+\w/ ) {
                   my $string = $_;
		   $string  =~ s/def//g;
		   $string  =~ s/\r|\n//g;

                   if ( $string =~ /\w\(/ ){
                   	$string =~ s/\(/\,/g;
                   	$string =~ s/\)//g;
                   	$string =~ s/\s*//g;
			my ( $action, @params ) = split(',', $string); 
			$controllers{$cntrl_name}{$count} ={ action => $action, args => \@params};
                   	$count++;
		   } else {
                   	$string =~ s/\s*//g;
			my $action = $string;
			$controllers{$cntrl_name}{$count} ={ action => $action, args => []};
                   	$count++;
                   }

               }
            }
        }
    }

    closedir $dh;

    return \%controllers;
}

sub routes_parser {
    my $app_dir = shift;
    my %routes  = ();
    open( my $ofh, "<", $app_dir . "/config/routes.rb" )
      or die "Unable to open routes.rb file";

    while ( my $string = <$ofh> ) {

        # handle get. post request routes
        if ( $string =~ /((get|post)\s+\".*\")/ ) {
            my $route = $1;
            $route =~ s/\s+/ /g;
            my ( $request_type, $value ) = split( ' ', $route );
            $value =~ s/"//g;
            my ( $route_name, $action ) = split( '/', $value );
            $routes{$route_name}{$request_type} = $action;
        }
    }

    # TODO: update this function to parse other route definitions
    return \%routes;

}
