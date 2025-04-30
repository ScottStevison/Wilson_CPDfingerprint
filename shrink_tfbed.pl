#!/usr/bin/perl

use strict;
use warnings;

while ( my $line = <STDIN> )
{
	chomp $line;
	my @fields = split /\t/, $line;
		$fields[1] += 100;
		$fields[2] -= 100;
		print "$fields[0]\t$fields[1]\t$fields[2]\t$fields[3]\t$fields[4]\t$fields[5]\n";

}
