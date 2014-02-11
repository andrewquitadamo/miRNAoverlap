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

	my @temp;
	my @miRNA;
	foreach(@file)
	{
		@temp = split("\t", $_);
		#push(@miRNA,@temp[0]);
		$overlap{lc(@temp[0])}++;
	}

	while ( my ($key, $value) = each(%overlap) ) 
	{
		print "$key => $value\n";
    	}
}

sub TCGA_NMF()
{
        open(FILE, "miRNA-all-NMF.txt") || die "Couldn't open file:  miRNA-all-NMF.txt";
        my @file = <FILE>;
        close FILE;

        shift(@file);

        my @temp;
        my @miRNA;
        foreach(@file)
        {
                @temp = split("\t", $_);
                push(@miRNA,@temp[0]);
        }

        print "@miRNA";
}

TCGA_hier;
#TCGA_NMF;
