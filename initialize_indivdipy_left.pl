#!/usr/bin/perl

use strict;
use warnings;

my %genome;
my $chr = "";
while ( <STDIN> )
{
	chomp $_;
	if ( $_ =~ /(chr[XIVM]+)/ )
	{
		print $_ . "\n";
		$chr = $1;
	}
	else
	{
		$genome{$chr} .= $_;
	}

}

my @dinucs = ("TT", "TC", "CT", "CC" );
foreach my $di ( @dinucs )
{
open ( PLUS, ">initial_plus_inbetween_${di}.wig" );
open ( MINUS, ">initial_minus_inbetween_${di}.wig" );
# find dipyrimindes in plus strand
foreach my $chrom (sort keys %genome )
{
	print "Processing $chrom\n";
	print PLUS "variableStep chrom=$chrom span=1\n";
        print MINUS "variableStep chrom=$chrom span=1\n";

	my $prev_plus_dipy_flag = 0;
	my $prev_minus_dipy_flag = 0;
	my $seq = $genome{$chrom};
	for ( my $i = 0; $i < length($seq) - 1; $i++ )
	{
		my $subseq = substr( $seq, $i, 2 );
                my $start = $i + 1; # make 1-based for wig
                my $end = $i + 2; # make 1-based for wig

		my $revdi = reverse $di;
		$revdi =~ tr/ACGT/TGCA/;

		if ( $subseq eq $di )
		{
			print PLUS "$start\t0.0\n";
		}
                if ( $subseq eq $revdi )
                {
                        print MINUS "$start\t0.0\n";
                }
	}

} 
close (PLUS);
close (MINUS);
