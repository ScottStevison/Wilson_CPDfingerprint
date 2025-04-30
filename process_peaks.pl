use strict;
use warnings;

my $factor = "Hap235";
while ( my $line = <STDIN> )
{
	chomp $line;
	if ( $line =~ /^(chr[XIV]+):([0-9]+) ([+-])$/ )
	{
		my $end = $2;
		my $start = $end - 1;
		print "$1\t$start\t$end\t$factor\t.\t$3\n";
	}
	else
	{
		die "no match: $line\n";
	}
}
