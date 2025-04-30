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

open ( PLUS, ">initial_plus_inbetween_dipy.wig" );
open ( MINUS, ">initial_minus_inbetween_dipy.wig" );
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
                my $mid = ( $start + $end ) / 2.0;

		if ( $subseq =~ /[CT][CT]/ )
		{
			print PLUS "$mid\t0.0\n";
		}
                if ( $subseq =~ /[AG][AG]/ )
                {
                        print MINUS "$mid\t0.0\n";
                }
	}

} 
close (PLUS);
close (MINUS);
