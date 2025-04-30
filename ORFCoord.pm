#!/usr/bin/perl

use strict;
use warnings;

package ORFCoord;

sub new
{
	my ($class) = @_;
	
	my $self = bless {}, $class;

	# open file with gene positions
	open( GENE, "../Saccharomyces_cerevisiae.R64-1-1.113.proc.gtf" ) || die "Couldn't open file\n";
	my $header = <GENE>;

	my %chromosome;
	my %tss;
	my %tts;
	my %strand;
	
	while( my $line = <GENE> )
	{
		chomp($line);
		my @fields = split /\t/, $line;
		if( $fields[0] =~ /^(Y[A-P][LR][0-9]+[CW]\-*[A-C]*)/ )
		{
			my $acc = $1;
			my $chr_name = $fields[2];
			$tss{$acc} = $fields[4]; 
			$tts{$acc} = $fields[5];
			push @{$chromosome{$chr_name}}, $acc;
			$strand{$acc} = $fields[3];
	
		}
	}

	close ( GENE );
	$self->{'chromosome'} = \%chromosome;
	$self->{'tss'} = \%tss;
	$self->{'tts'} = \%tts;
	$self->{'strand'} = \%strand;

	return $self;	
}

sub get_chromosomes
{
	my ($self) = @_;

	return %{$self->{'chromosome'}};

}

sub get_tss
{
        my ($self) = @_;

        return %{$self->{'tss'}};
}

sub get_tts
{
        my ($self) = @_;

        return %{$self->{'tts'}};
}

sub get_strand
{
        my ($self) = @_;

        return %{$self->{'strand'}};
}
	
	

1;	
