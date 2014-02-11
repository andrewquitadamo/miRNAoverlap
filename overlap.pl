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
                #print $key . "=>" . $value . "\n";
        }	
}

sub marchini()
{
        open(FILE, "miRNA-initial.csv") || die "Couldn't open file:  miRNA-initial.csv";
        my @file = <FILE>;
        close FILE;

        shift(@file);

	my %miRNA;
	my @temp;
	foreach(@file)
	{
		@temp = split(",",$_);
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

sub HMDD2()
{
        open(FILE, "HMDD2") || die "Couldn't open file:  HMDD2";
        my @file = <FILE>;
        close FILE;

        shift(@file);

        my %miRNA;
        my @temp;
        foreach(@file)
	{
		@temp = split("\t",$_);
		if (index(@temp[2], "Ovarian") != -1) 
		{
			$miRNA{lc(@temp[1])}++;
		}
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

sub miR2Disease()
{
        open(FILE, "miRmasterlist") || die "Couldn't open file:  miRmasterlist";
        my @file = <FILE>;
        close FILE;

        shift(@file);

        my %miRNA;
        my @temp;
        foreach(@file)
        {
                @temp = split("\t",$_);
                if (index(@temp[1], "ovarian") != -1)
                {
			#print 
                        $miRNA{lc(@temp[0])}++;
                }
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

sub miRCancer()
{
        open(FILE, "miRCancer.txt") || die "Couldn't open file:  miRCancer.txt";
        my @file = <FILE>;
        close FILE;

        shift(@file);

        my %miRNA;
        my @temp;
        foreach(@file)
        {
                @temp = split("\t",$_);
                if (index(@temp[1], "ovarian") != -1)
                {
                        #print
                        $miRNA{lc(@temp[0])}++;
                }
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

sub miRdSNP()
{
        open(FILE, "mirdsnp-snp-mir-distance.csv") || die "Couldn't open file:  mirdsnp-snp-mir-distance.csv";
        my @file = <FILE>;
        close FILE;

        shift(@file);

        my %miRNA;
        my @temp;
        foreach(@file)
        {
                @temp = split(",",$_);
		if (index(@temp[4], "Ovarian") != -1)
                {
                        $miRNA{lc(@temp[2])}++;
                }
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

sub Phenomir2()
{
        open(FILE, "Phenomir2.tbl") || die "Couldn't open file:  Phenomir2.tbl";
        my @file = <FILE>;
        close FILE;

        shift(@file);

        my %miRNA;
        my @temp;
        foreach(@file)
        {
                @temp = split("\t",$_);
                if (index(@temp[2], "Ovarian") != -1)
                {
			$miRNA{lc(@temp[5])}++; 
                }
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
TCGA_hier;
TCGA_NMF;
marchini;
HMDD2;
miR2Disease;
miRCancer;
miRdSNP;
Phenomir2;
