#!/usr/bin/perl

use strict;
use warnings;

while ( my $line = <STDIN> )
{
	chomp $line;
	if ( $line =~ /^variableStep/ )
	{
		print "$line\n";
	}
	else
	{
		my @fields = split /\t/, $line;

		my $pos = int ( $fields[0] );
		print "$pos\t$fields[1]\n";	
	}
}

