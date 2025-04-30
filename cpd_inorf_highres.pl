#!/usr/bin/perl

use strict;
use warnings;

use lib '../';
use GeneCoord;
use CPDReadValues;

# ask for probe filename to analyze
print STDERR "Enter filename of plus strand reads\n";
my $plusfile = <STDIN>;
chomp($plusfile);

print STDERR "Enter filename of minus strand reads\n";
my $minusfile = <STDIN>;
chomp($minusfile);

print STDERR "Loading Gene coordinates\n";
my $genes = GeneCoord->new();
print STDERR "Loading Probe Values\n";
my $reads = CPDReadValues->new($plusfile, $minusfile);

# location offsets
my $upstream_offset = -499.5;
my $downstream_offset = 639.5;

# START FROM HERE
my %chromosomes = $genes->get_chromosomes();
my %trxstart = $genes->get_tss();
my %trxend = $genes->get_tts();
my %strand = $genes->get_strand();

#print header
print "Data from file: $plusfile\t$minusfile\n";
print "Gene\tCOUNT_TYPE";

for (my $i = $upstream_offset; $i <= $downstream_offset; $i++ )
{
	print "\t$i";
}
print "\n";

foreach my $chr (sort keys %chromosomes)
{
	print STDERR "Starting $chr\n";
	my %plusreads = $reads->get_plus_reads_for_chromosome($chr);
	my $num_plusreads = scalar keys %plusreads;
	my %minusreads = $reads->get_minus_reads_for_chromosome($chr);
	my $num_minusreads = scalar keys %minusreads;
	print STDERR "$chr reads: $num_plusreads plus reads and $num_minusreads minus reads\n";
	foreach my $acc ( @{$chromosomes{$chr}} )
	{
		my $tss = $trxstart{$acc};
		my $tts = $trxend{$acc};
		
		my @cpds = ();
		# calculate read sums (CPD and DIPY bkgd) for gene
		for ( my $i = $upstream_offset; $i <= $downstream_offset; $i++)
		{
			my $pos;
			if ( $strand{$acc} eq "+" )
			{
				$pos = $tss + $i;
			}
			elsif ( $strand{$acc} eq "-" )
			{
				$pos = $tss - $i;
			}
			else
			{
				die "No strand information for gene: $acc\n";
			}
			my $cpdcount = 0;
			if ( exists $plusreads{$pos} )
			{
				$cpdcount += $plusreads{$pos};
			}
			if ( exists $minusreads{$pos} )
			{
				$cpdcount += $minusreads{$pos};
			}
			push @cpds, $cpdcount;
		}
  
		# print average probe values for acc
		print "$acc\tCPDs";

		foreach my $val (@cpds)
		{
			print "\t$val";
		}
		print "\n";
	}

}
