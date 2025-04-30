#!/usr/bin/perl

use strict;
use warnings;

my %dinuc_count;
my $count = 0;
while ( my $line = <STDIN> )
{
	chomp $line;
	if ($line =~ /^>([0-9]+)\(/ )
	{
		$count = $1;
		next;
	}
	
	$dinuc_count{$line} += $count;

}

foreach my $key (sort keys %dinuc_count)
{
	print "$key\t$dinuc_count{$key}\n";

}
