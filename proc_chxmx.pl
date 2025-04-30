#!/usr/bin/perl

use strict;
use warnings;

my %chrlookup = ( "chr1" => "chrI", "chr2" => "chrII", "chr3" => "chrIII", "chr4" => "chrIV", "chr5" => "chrV", "chr6" => "chrVI", "chr7" => "chrVII", "chr8" => "chrVIII", "chr9" => "chrIX", "chr10" => "chrX", "chr11" => "chrXI", "chr12" => "chrXII", "chr13" => "chrXIII", "chr14" => "chrXIV", "chr15" => "chrXV", "chr16" => "chrXVI", "chrM" => "chrM");

while ( my $line = <STDIN> )
{
	chomp $line;
	my @fields = split /\t/, $line;
	my $chr = $fields[0];
	$chr = $chrlookup{$chr} || die "Weird chromosome: $chr\n";
	print "$chr\t$fields[1]\t$fields[2]\t$fields[3]\t$fields[4]\t+\n";
}
