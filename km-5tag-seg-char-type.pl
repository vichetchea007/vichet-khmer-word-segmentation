#!/usr/bin/perl -w

#############################################
## last update: 11-Jan-2016
## by : Vichet Chea
## email: vichet.chea@niptict.edu.kh
## tel: (+855)-77-657-007
## website: www.niptict.edu.kh
#############################################

####################################################################################
# This is a function script. It is used by another script to get type of character #
####################################################################################

use warnings;
use strict;
use utf8;
use File::Basename; 

my $c = "[ក-អ]";
my $v = "[ា-ៈ]";
my $iv = "[ឤឥឦឧឩឳឰឬឫឭឮឯឱឲឪ]";
my $upperSign = "[៉-៑]";		#not use
my $endSign = "[៓-៝]";	
my $atakNumber = "[៰-៹]";
my $lunarNumber = "[᧠-᧿]";
my $sub = "[្]";
my $nk = "[០១២៣៤៥៦៧៨៩]";
my $ne = "[0123456789]";
my $latin = "[a-zA-Z']";		# a..z A..Z and ' (single quote sign) are considered as LATIN aphabet


my $zspace= "\x{200B}";			#zero space (invisible space)
my $isNoSpace;

sub getCharType {

		my $char = $_[0];
		my $nextChar = $_[1];
		my $type="";
		
		if ($char =~ m/($c)/) {			
			$type = "C";
		}elsif ($char =~ m/($v)/) {
			$type = "V";
		}elsif ($char =~ m/($iv)/) {
			$type = "IV";
		}elsif ($char =~ m/($upperSign)/) {
			$type = "US";		
		}elsif ($char =~ m/($atakNumber)/) {
			$type = "AN";
		}elsif ($char =~ m/($lunarNumber)/) {
			$type = "LN";
		}elsif ($char =~ m/($sub)/) {
			$type = "SUB";
		}elsif ($char =~ m/($endSign)/) {
			$type = "END";	
		}elsif ($char =~ m/$zspace/) {
			$type = "ZS";								
		}elsif ($char =~ m/($latin)/) {
			$type = "NS";	#No Space after this char
		}elsif ($char =~ m/($ne)/) {
			$type = "NS";	#No Space after this char		
		}elsif ($char =~ m/($nk)/) {
			$type = "NS";	#No Space after this char		
		}else {
			$type = "UNK";	#Unknown
		}
		
		$isNoSpace = ($nextChar =~ m/$nk/);
		$isNoSpace +=  ($nextChar =~ m/$ne/);
		$isNoSpace +=  ($nextChar =~ m/$latin/);
		
		if ($isNoSpace > 0) {
				$type = "NS";		#No Space
		}
		return $type;
}

1
