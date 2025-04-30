#!/usr/bin/perl

use strict;
use warnings;

my $chromosome = "";
my %mutationcount;
my %misformatted;

my %chrlookup = ( "chr1" => "chrI", "chr2" => "chrII", "chr3" => "chrIII", "chr4" => "chrIV", "chr5" => "chrV", "chr6" => "chrVI", "chr7" => "chrVII", "chr8" => "chrVIII", "chr9" => "chrIX", "chr10" => "chrX", "chr11" => "chrXI", "chr12" => "chrXII", "chr13" => "chrXIII", "chr14" => "chrXIV", "chr15" => "chrXV", "chr16" => "chrXVI", "chrM" => "chrM");

while ( my $line = <STDIN> )
{
	chomp $line;
	my @fields = split /\t/, $line;
	my $chr = $fields[0];
	$chr = $chrlookup{$chr} || die "Weird chromosome: $chr\n";
	
	if ( $chromosome ne $chr )
	{
		if ( $chromosome ne "" )
		{
			# print off all values for previous chromosome

			print STDERR "Finished with Chromosome $chromosome\n";
			print "variableStep chrom=$chromosome span=1\n";

			foreach my $pos ( sort {$a <=> $b} keys %mutationcount )
			{
				print "$pos\t$mutationcount{$pos}\n";
			}
		}
		%mutationcount = ();
		$chromosome = $chr;
	}

	my $start = $fields[1];
	my $end = $fields[2];

	if ( ($end - $start) != 1 )
	{
		die "Non-1bp mutations!\n";
	}

	# want 1-based start so add 1 to start (assuming input is 0-based start bed file)
	$start++;

	if ( $start != $end )
	{
		die "non 1bp mutation!\n";
	}

	# add to cpd_count hash
	$mutationcount{$start}++;
}

# print off all values of last chromosome

print STDERR "Finished with Chromosome $chromosome\n";
print "variableStep chrom=$chromosome span=1\n";

foreach my $pos ( sort {$a <=> $b} keys %mutationcount )
{
        print "$pos\t$mutationcount{$pos}\n";
}

print STDERR "counts of misformatted lines:\n";
foreach ( sort keys %misformatted )
{
	print STDERR "$_ $misformatted{$_} lines\n";

}
