use strict;
use warnings;

my $file = "nochmx_hap235targets.txt";
open (FILE, $file) || die "no file\n";

my %nochx = ();
while ( <FILE> )
{
	chomp $_;
	$nochx{$_} = 1;

}

print STDERR "Enter bedfile name:\n";
my $bed = <STDIN>;
chomp $bed;

open (BED, $bed ) || die "no bed file\n";
my $bound = $bed;
$bound =~ s/\.bed/_chxmx.bed/;
open (BOUND, ">$bound" );

my $unbound = $bed;
$unbound =~ s/\.bed/_NOTchxmx.bed/;
open (UNBOUND, ">$unbound" );

while ( my $line = <BED> )
{
	chomp $line;
	my @fields = split /\t/, $line;
	if ( exists $nochx{$fields[3]} && $nochx{$fields[3]} == 1 )
	{
		print UNBOUND "$line\n";
	}
	else
        {
                print BOUND "$line\n";
        }

}
