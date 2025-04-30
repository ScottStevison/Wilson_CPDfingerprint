use strict;
use warnings;
while ( my $line = <STDIN> )
{
	chomp $line;
	if ( $line =~ /^(chr[XVIM]+):([0-9]+) ([+-])$/ )
	{
		my $end = $2;
		my $start = $end - 1;
		print "$1\t$start\t$end\t$line\t.\t$3\n";
	}
	else
	{
		die "weird line: $line\n";	
	}
}
