#!/usr/bin/perl

use strict;
use warnings;

# code adapted from Nature protocols paper by Ding, Tayor, Reijns 2015

while ( my $line = <STDIN> )
{
	my @field = split /\t/, $line;
	if ( $field[5] =~ /\+/ )
	{
		$field[2] = $field[1] + 1;
	}
	elsif ( $field[5] =~ /-/ )
	{
		$field[1] = $field[2] - 1;
	}
	else
	{
		die "weird line: $line\n";
	}
	if ( $field[1] >= 0 )
	{
		print join "\t", @field;
	}
}

