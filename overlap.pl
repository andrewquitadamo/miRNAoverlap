#usr/bin/perl
#use strict;
#use warnings;

my %overlap;

sub TCGA_hier()
{
	open(FILE, "miRNA-all-hierarchical.txt") || die "Couldn't open file:  miRNA-all-hierarchical.txt";
	my @file = <FILE>;
	close FILE;

	shift(@file);

	my %miRNA;
	my @temp;
	foreach(@file)
	{
		@temp = split("\t", $_);
		$miRNA{lc(@temp[0])}++;
	}

	while ( my ($key) = each(%miRNA) ) 
	{
		$overlap{$key}++;
    	}

	while ( my ($key, $value) = each(%overlap) )            
        {
                #print $key . "=>" . $value . "\n";
        }
}

sub TCGA_NMF()
{
        open(FILE, "miRNA-all-NMF.txt") || die "Couldn't open file:  miRNA-all-NMF.txt";
        my @file = <FILE>;
        close FILE;

        shift(@file);

	my %miRNA;
        my @temp;
        foreach(@file)
        {
                @temp = split("\t", $_);
        	$miRNA{lc(@temp[0])}++;
	}
	
        while ( my ($key) = each(%miRNA) )            
        {
                $overlap{$key}++;
        }

        while ( my ($key, $value) = each(%overlap) )
        {
                print $key . "=>" . $value . "\n";
        }	
}

sub marchini()
{
        open(FILE, "miRNA-initial.csv") || die "Couldn't open file:  miRNA-initial.csv";
        my @file = <FILE>;
        close FILE;

        shift(@file);
}

TCGA_hier;
TCGA_NMF;
