#!/usr/bin/perl -w

#############################################
#  Converting a CRF into Line format
#############################################
## last update: 30-Aug-2016
## by : Vichet Chea
## email: vichet.chea@niptict.edu.kh
## tel: (+855)-77-657-007
## website: www.niptict.edu.kh
#############################################


use warnings;
use strict;
use utf8;

binmode(STDIN, ":utf8");
binmode(STDOUT, ":utf8");

sub usage {
	print "\nUsage:\n";
	print "\t$0 input_file [output_file] [-c | -w]\n\n";	
	print "This script is to convert un-segmented line into CRF format\n\n";
	print "-c	display as word and compound word including prefix and suffix (defaut)\n";
	print "-w	display as word\n";
	print "\n\n";
	exit;
}

my $num_arg = (scalar @ARGV);
if ($num_arg < 1) {
	usage();
}

my $start = time;


my $input = $ARGV[0];
open (IN, "<:encoding(utf8)", $input) or die "In $0, line ", __LINE__ ,": Can not open input file\n";

my $option = "-c";
my $output= "";

if ($num_arg >= 2) {
	$output = $ARGV[1];
	if (($output eq "-w") || ($output eq "-c")) {
		$option = $output;
		$output = "";
	} else {
		open (OUT, ">:encoding(utf8)", $output) or die "In $0, line ", __LINE__ ,": Can not open input file\n";
	}
}

if ($num_arg >= 3) {
	$option = $ARGV[2];	
	if (($option ne "-w") && ($option ne "-c")) {
		usage();
	}
}

my $line;
my $char = "";
my $type = "";
my $tag = "";

my $zspace = "\x{200B}";
my $space = " ";


my $i = 0;
my $result = "";

require("km-progress.pl");
initProgress($input);

my @rows;

while (<IN>) {
	
	$line = $_;		# read line by line	
	$line =~ s/\r//g;		# remove return char (enter key)	
	
	if (($line ne "\n")) {	## if not blank line
		@rows = split("\t", $line);		#convert line into array spliting by tab char
		chomp $line;						
		$line .= " ";
		
		$char = $rows[0];							
		$type = $rows[1];									
		$tag = $rows[2];
		
		# --------
		# this block is to keep original space.
		# zero space is manually noted as original space.
		# comment this block to keep original space.

		# if ($char eq $zspace) {
		#	$char = $space;
		# }
		
		# -----------

		$tag =~ s/\s$//g;
			
		$result .= $char;
		
		if ($type eq "NS") {  # No Space after this char
			#no need space
		} else {			
			if ($tag eq "0") {	## no space 
				# do nothing
			}else { ## have space or notation
				$tag =~ s/$zspace/ /g;
				$tag =~ s/\}\{/ /g;
				$tag =~ s/\}/ /g;
				
				
				if ($option eq "-w") {
						$tag =~ s/\~//g;			
						$tag =~ s/\_//g;			
						$tag =~ s/\^//g;			
				}elsif ($option eq "-c") {
						# to keep it, just do nothing here
				}
				
				
				$result .= $tag;				
			}			
		}
	} else {
		$result = numberRule($result);
		$result = latinRule($result);	
		$result .= "\n";					
		$result =~ s/  / /g;
		
		if ($output eq "") {
			print $result;
		}else {
			if ($option ne "") {
				printProgress($.);		# call sub in km-progress.pl	
				print OUT $result;
			}
			
		}
		$result = "";
}
	
}
print "\n";
close OUT;

sub postclean {
	$result = $_[0];
	$result = "{" . $result ."}" ;	
	$result =~ s/\s/}{/g;	
	$result =~ s/{$//g;
	$result =~ s/{ / {/g;
	$result =~ s/ }/} /g;
	$result =~ s/{}//g;
	
	$result =~ s/^ //g;
	$result =~ s/ $//g;
	
	return $result;
}

sub numberRule {
	$result = $_[0];
	
	$result =~ s/([^\d^,^\.\:\?])([\d])/$1 $2/g;
	$result =~ s/([\d])([^\d^,^\.\:\?])/$1 $2/g;	
	
	#$result =~ s/([^\d])([\d])/$1 $2/g;		# 1.5 ==> 1 . 5
	#$result =~ s/([\d])([^\d])/$1 $2/g;	
	
	$result =~ s/  / /g;	
	return $result;
}

sub latinRule {
	$result = $_[0];
	
	$result =~ s/([^a-zA-Z'])([a-zA-Z])/$1 $2/g;	# 's not put space in between
	$result =~ s/([a-zA-Z])([^a-zA-Z])/$1 $2/g;	
	
	$result =~ s/  / /g;	
	return $result;
}


my $duration = time - $start;
print STDERR "\nExecution time: $duration s\n";
