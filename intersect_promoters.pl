#!/usr/bin/perl 
# intersect_TFBS.pl

use strict;
use warnings;

print STDERR "Enter filename of TFBS to intersect with PROM coordinates\n";
my $tfbs_file = <STDIN>;
chomp $tfbs_file;
open ( TFBS, $tfbs_file ) || die "Couldn't open file: $tfbs_file\n";

# open PROM coordinates
print STDERR "Enter filename of PROM coordinate file:\n";
my $prom_file = <STDIN>;
chomp $prom_file;
open (PROM, $prom_file) || die "Couldn't open promoter file: $prom_file\n";
print STDERR "processing PROM coordinates...\n";

# process promoters into lookup hash (1 => promoter, undef/not exist ==> not promoter)
# I am assuming these coordinates are 0 based
my %PROM_coord;
my $chr = "";
while ( my $line = <PROM> )
{
	chomp $line;
	my @fields = split /\t/, $line;
	if ( $fields[0] =~ /(chr[IXVM]+)/ )
	{
		my $temp = $1;
		if ( $chr ne $temp )
		{
			print STDERR "Starting to process $temp\n";
			$chr = $temp;
		}

		push @{$PROM_coord{$chr}}, [$fields[1], $fields[2]];
	}
	else
	{
		die "Misformatted line: $line\n";
	}
}
close (PROM);

# intersect TF coordinates with PROM --> any overlap means active PROM TF

$tfbs_file =~ s/\.bed//;

my $InPROM_file = $tfbs_file . "_PROM.bed";

my $notInPROM_file = $tfbs_file . "_notPROM.bed";

open (PROM, ">$InPROM_file") || die "Couldn't open InPROM file: $InPROM_file\n";
open (NOTPROM, ">$notInPROM_file") || die "Couldn't open NOTInPROM file: $notInPROM_file\n";

print STDERR "Starting processing TFBS coordinates...\n";
$chr = "";
my %PROM_lookup;
while ( my $line = <TFBS>)
{
	chomp $line;
	my @fields = split /\t/, $line;
        if ( $fields[0] =~ /(chr[IXVM]+)/ )
        {
		my $temp = $1;
		if ( $temp ne $chr )
		{
                	print STDERR "Starting to process $temp\n";
			$chr = $temp;
			# empty hash
			%PROM_lookup = ();
			foreach my $prom ( @{$PROM_coord{$chr}} )
			{
				my $start = $prom->[0];
				# start coordinate is 0-based, so convert to 1-based for consistency
				$start++;
				my $end = $prom->[1];
                		for ( my $i = $start; $i <= $end; $i++ )
                		{
                        		# Define this nucleotide as a promoter
                        		$PROM_lookup{$fields[0]}{$i} = 1;
                		}
			}
		}
                my $start = $fields[1] + 1; # to make it 1-based instead of 0-based for consistency
		my $end = $fields[2]; # already 1 based
		my $prox_flag = 0;
		for ( my $i = $start; $i <= $end; $i++ )
		{
			if ( exists $PROM_lookup{$chr}{$i} && $PROM_lookup{$chr}{$i} == 1 )
			{
				$prox_flag = 1;	
			}
		}

                if ( $prox_flag )
                {
                        print PROM "$line\n";
                }
                else
                {
                        print NOTPROM "$line\n";
                }
	}
	else 
	{
		die "Misformatted line: $line\n";
	}
}
