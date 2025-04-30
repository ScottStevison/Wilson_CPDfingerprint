#!/usr/bin/perl

use warnings;
use strict;

my $numargs = scalar @ARGV;
if ( $numargs < 2 )
{
	die "You need to pass at least 2 wig filenames as arguments; usage: perl add_UV_wig_files.pl <wigfile1> <wigfile2> ...\n";
}

my %reads;

foreach my $wigfile ( @ARGV )
{
	open ( WIG, $wigfile ) || die "Couldn't open file $wigfile\n";
	my $chr = "";
	while ( my $line = <WIG> )
	{
	        chomp $line;
	        if ( $line =~ /chrom=(chr[0-9A-Za-z_]+) / )
	        {
	                $chr = $1;
	        }
	        else
	        {
	                my @field = split /\t/, $line;
	                $reads{$chr}{$field[0]} += $field[1];
	        }
	}
	close ( WIG );
}

foreach my $chrom (sort keys %reads )
{
        print "variableStep chrom=$chrom span=1\n";
	my %temp = %{$reads{$chrom}};
	foreach my $pos (sort { $a <=> $b } keys %temp )
	{
		print "$pos\t$temp{$pos}\n";
	}
} 
