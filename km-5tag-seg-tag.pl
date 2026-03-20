#!/usr/bin/perl -w

#############################################
## last update: 11-Jan-2016
## by : Vichet Chea
## email: vichet.chea@niptict.edu.kh
## tel: (+855)-77-657-007
## website: www.niptict.edu.kh
#############################################

##################################################################
# This script is a function script. It is used by another script #
##################################################################

use warnings;
use strict;
use utf8;
use File::Basename; 

sub getTag {

		my $nextChar = $_[0];
		my $i = $_[1];		
		
		my $tag;
				if ($nextChar =~ /\s/ ) {					
							$i++;								
							$tag	= "}{";	#	word}{word							
				}elsif ($nextChar =~ /~/ ) {					
							$i++;
							$tag = "~";	# prefix~word
				}elsif ($nextChar =~ /\^/ ) {					
							$tag = "^";
							$i++;
				}elsif ($nextChar =~ /_/ ) {										
							$tag = "_";
							$i++;
				}else {
							$tag = "0";	# no space	Char1Char2Char3
				}				
				
		$_[1] = $i;		# set the value back to the reference variable
		return $tag;
}

1
