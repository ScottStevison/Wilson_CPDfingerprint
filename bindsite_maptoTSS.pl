use strict;
use warnings;

use lib '../';
use GeneCoord;
use CPDReadValues;

my $window = 700;
my %tss =  ();

my %internal = ();

print STDERR "Loading gene coordinates\n";
my $genes = GeneCoord->new();

# START FROM HERE
my %chromosomes = $genes->get_chromosomes();
my %trxstart = $genes->get_tss();
my %trxend = $genes->get_tts();
my %strand = $genes->get_strand();

foreach my $chr (sort keys %chromosomes)
{
        foreach my $acc ( @{$chromosomes{$chr}} )
        {
                my $tss = $trxstart{$acc};
                $tss{$chr}{$tss} = $acc;
		if ( exists $trxend{$acc} )
		{
	                my $tts = $trxend{$acc};
	                if ( $strand{$acc} eq "+" )
	                {
	                        for ( my $i = $tss; $i <= $tts; $i++ )
	                        {
	                                $internal{$chr}{$i} = $acc;
	                        }
	                }
	                elsif ( $strand{$acc} eq "-" )
	                {
	                        for ( my $i = $tss; $i >= $tts; $i-- )
	                        {
	                                $internal{$chr}{$i} = $acc;
	                        }
	                }
	                else
	                {
	                        die "weird strand\n";
	                }
		}
        }
}
while ( my $line = <STDIN> )
{
	chomp $line;

	my @fields = split /\t/, $line;
	my $chrom = $fields[0];

	my $tfbs = $fields[1] + 1; # add one to make 1-based;
	if ( $tfbs != $fields[2] ) 
	{
		die "Weird line: $line\n";
	}

	my %genes = ();
	for ( my $i = (-1 * $window ); $i <= ($window ); $i++ )
	{
		my $pos = $tfbs + $i;
		if ( exists $tss{$chrom}{$pos} )
		{
			my $acc = $tss{$chrom}{$pos};
			my $str = $strand{$acc};
			if ( $str eq "+" )
			{
				$genes{$acc} = (-1 * $i);
			}
			elsif ( $str eq "-" )
			{
				$genes{$acc} = $i;
			}
			else
			{
				die "No strand!\n";
			}
			print "${chrom}:$tfbs $fields[5]\t$acc\t$genes{$acc}\n";
		}
	}

	if ( exists $internal{$chrom}{$tfbs} )
	{
		my $acc = $internal{$chrom}{$tfbs};
		my $acctss = $trxstart{$acc};
		my $dist = $tfbs - $acctss;
		if ( $strand{$acc} eq "-" )
		{
			$dist *= -1;
		}
		print "${chrom}:$tfbs $fields[5]\t$acc\t$dist\tinsideORF\n";
	}
	elsif ( !%genes )
	{
		print "${chrom}:$tfbs $fields[5]\tN/A\tN/A\n";
	}
} 

