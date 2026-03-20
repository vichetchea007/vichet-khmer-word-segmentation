#!/usr/bin/perl

#############################################
#  Converting a LINE into CRF format
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
use File::Basename; 

binmode(STDIN, ":utf8");
binmode(STDOUT, ":utf8");

my $num_arg = (scalar @ARGV);
if ($num_arg < 1) {
	print "\nUsage:\n";
	print "\t$0 input_file [output_file] \n\n";	
	print "This script is to convert un-segmented line into CRF format.";
	print "\n\n";
	exit;
}

my $start = time;



require("km-5tag-seg-char-type.pl");
#require("km-5tag-seg-tag.pl");		#for training only

my $input = $ARGV[0];
open (IN, "<:encoding(utf8)", $input) or die "In $0, line ", __LINE__ ,": Can not open input file\n";


if ($num_arg == 2) {
	my $output = $ARGV[1];
	open (OUT, ">:encoding(utf8)", $output) or die "In $0, line ", __LINE__ ,": Can not open input file\n";
}


my $line;
my $zspace= "\x{200B}";			#zero space (invisible space)
my $space = " ";					
my $emply = "";

sub preclean {
	#clean
	my $line = $_[0];
	$line =~ s/^\s+|\s+$//g;
	
	# start remove all zero space otherwise it cause breaking word problem
	$line =~ s/$zspace//g;	
		
	# end of remove zero space
	
	$line =~ s/\x{00A0}/ /g;	# it is also one space
	$line =~ s/^\s//g;
	$line =~ s/\s$//g;	
	$line =~ s/\t/ /g;		#convert tab to space
	$line =~ s/ +/ /g;	
		
	# it is very importan
	# if testing, convert space ==> zero space 
	# but for training, SPACE must be keept
	$line =~ s/ /$zspace/g;			
	
	
	$line =~ s/^\s//g;	
	$line =~ s/\s$//g;	
	return $line;
}


my $char = "";
my $type = "";
my $tag = "";
my $nextChar;
my @str;
my $n;


require("km-progress.pl");
initProgress($input);

my $i;
my $row= "";				
my $p;
	
while (<IN>) {

	$line = $_;	
	chomp $line;
	
	$line = preclean($line);

	@str = split //, $line;		
	push @str, " ";		#for new line
	
	$n = (scalar @str);
	
	
	for ( $i= 0; $i < $n-1 ; $i++) {
		$char = $str[$i];		
		$nextChar = $str[$i+1];		
		$type = getCharType($char, $nextChar);
		
		$row = $char . "\t" . $type ;
		
		if ($num_arg == 1) {
			print "$row\n";			
		} elsif ($num_arg == 2) {
			print OUT "$row\n";								
		}
	}
	
	if ($num_arg == 1) {
		print "\n";		
	} elsif ($num_arg == 2) {
		printProgress($.);		# call sub in km-progress.pl
		print OUT "\n";		
	}
}

close IN;

my $duration = time - $start;
print STDERR "\nExecution time: $duration s\n";
