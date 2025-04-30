use strict;
use warnings;

# code adapted from Nature protocols paper by Ding, Tayor, Reijns 2015

while ( my $line = <STDIN> )
{
	chomp $line;
        my @field = split /\t/, $line;
        if ( $field[5] eq "+" )
	{	$field[5] = "-";	}
	elsif ( $field[5] eq "-" )
        {       $field[5] = "+";       }
	else
	{
		die "weird line: $line\n";
	}
                print join "\t", @field;
	print "\n";
}
