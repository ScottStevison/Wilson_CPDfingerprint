#!/usr/bin/perl

use warnings;
use strict;

my $numargs = scalar @ARGV;
if ( $numargs != 2 )
{
	die "You need to pass 2 wig filenames as arguments; usage: perl subtract_UV_wig_files.pl <initial 0 wigfile1> <wigfile2>\n";
}
my $floor = 1;
my $count1 = 0;
my $count2 = 0;
my %reads;
my %logreads;
my $skippedval = 0;
for ( my $i = 0; $i < scalar @ARGV; $i++ )
{
	my $wigfile = $ARGV[$i];
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
			if ( $i == 0 )
			{
	                	$reads{$chr}{$field[0]} = $field[1];
				$count1++;
			}
			elsif ( $i == 1 )
			{
				if ( defined $reads{$chr}{$field[0]} )
				{
					my $den = $field[1];
					if ( $den == 0 )
					{
						$den = $floor;
					}
					my $num = $reads{$chr}{$field[0]};
					if ( $num == 0 )
					{
						$num = $floor;
					}
					$logreads{$chr}{$field[0]} = log ( 1.0 * $num / $den ) / log (2);
				
					$count2++;
				}
				else 
				{
					die "missing value: $line\n";
				}
			}
			else
			{
				die "weird val\n";
			}
	        }
	}
	close ( WIG );
}

foreach my $chrom (sort keys %logreads )
{
        print "variableStep chrom=$chrom span=1\n";
	my %temp = %{$logreads{$chrom}};
	foreach my $pos (sort { $a <=> $b } keys %temp )
	{
		print "$pos\t$temp{$pos}\n";
	}
} 
print STDERR "skipped wig lines: $skippedval\nCount file 1: $count1\nCount file 2: $count2\n";

