#!/usr/bin/perl

use strict;
use warnings;

print STDERR "Opening FASTA file\n";
my $fa_file = "./saccer3_genome.fa";
# process sequence in fasta file
open(FASTA, $fa_file ) || die "Couldn't open fasta file\n";
print STDERR "Finished opening FASTA file\n";
my $totalnuc = 0;
my %tatanucs;
my $chr = "";
my $flag = 0;
my $seq = "";
my $motiflen = 5;
while ( my $line = <FASTA> )
{
        chomp $line;
	if ( $line =~ /^>([a-zA-Z0-9_]+)/ )
	{
		# count tatanucs in sequence from previous chromosome
		for ( my $i = 0; $i < (length($seq) - $motiflen + 1); $i++ )
        	{
                	my $tataseq = substr( $seq, $i, $motiflen );
			if ( $tataseq =~ /^[CA]TTCC$/ )
			{
				my $end = $i + $motiflen;
				print "$chr\t$i\t$end\tGcr1match\t.\t+\n";
			}
			elsif ( $tataseq =~ /^GGAA[TG]$/ )
			{
				my $end = $i + $motiflen;
                                print "$chr\t$i\t$end\tGcr1match\t.\t-\n"; 
			}
        	}
		$chr = $1;
		$seq = "";
		if ( $chr eq "pUC19" || $chr eq "chrM" )
		#if ( $chr eq "pUC19" )
		{
			print STDERR "$chr sequence was skipped\n";
			$flag = 1;
		}
		elsif ( $chr =~ /_/ )
		{
			print STDERR "Skipping chromosome $chr\n";
			$flag = 1;
		}
		else
		{
			print STDERR "Starting chromosome $chr\n";
			$flag = 0;
		}
		next;	# header of fasta
	}

	if ( $flag == 1 )
	{
		next;
	}
	else
	{
		$seq .= $line;
	}
}

if ( $flag == 0 )
{
                # count tatanucs in sequence from previous chromosome
                for ( my $i = 0; $i < (length($seq) - $motiflen + 1); $i++ )
                {
                        my $tataseq = substr( $seq, $i, $motiflen );
                        if ( $tataseq =~ /^[CA]TTCC$/ )
                        {
                                my $end = $i + $motiflen;
                                print "$chr\t$i\t$end\tGcr1match\t.\t+\n";
                        }
                        elsif ( $tataseq =~ /^GGAA[TG]$/ )
                        {
                                my $end = $i + $motiflen;
                                print "$chr\t$i\t$end\tGcr1match\t.\t-\n";
                        }
                }
}
