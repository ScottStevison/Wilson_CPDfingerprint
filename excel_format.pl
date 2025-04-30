#!/usr/bin/perl

use strict;

while(my $line = <STDIN>)
{
	chomp($line);
	$line =~ s///g;
	my @lines = split /::/, $line;
	foreach my $l (@lines)
	{
		print $l . "\n";
	}

}
