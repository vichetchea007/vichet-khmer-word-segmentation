#############################################
#
#  Showing progress indicator
#
#############################################
## last update: 30-Aug-2016
## by : Vichet Chea
## email: vichet.chea@niptict.edu.kh
## tel: (+855)-77-657-007
## website: www.niptict.edu.kh
#############################################


local $| = 1;

my $total_line = 0;

sub initProgress {
	my $input_file = $_[0];
	$total_line =  (split / /, (`wc -l $input_file`))[0];
}

sub printProgress {
		
		my $c = $_[0];
		
		if ($total_line eq "") { $total_line = 0; }
		if ($total_line == 0) {
			$total_line = 1;
			$c = 1;
		}

		if ($c > $total_line) { $c = $total_line;}
		
			
		$p = ($c/$total_line) * 100;
		if ($p > 100) { $p = 100;}
		
		$p = sprintf '%.2f', $p;		
		
		print STDERR "\r($p %) : $c of $total_line lines";
}
1
