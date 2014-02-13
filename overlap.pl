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
                #print $key . "=>" . $value . "\n";
        }
}

sub miRPD_croft()
{
        open(FILE, "croft_full.tsv") || die "Couldn't open file:  croft_full.tsv";
        my @file = <FILE>;
        close FILE;

        shift(@file);

        my %miRNA;
        my @temp;
        foreach(@file)
        {
                @temp = split("\t",$_);
                if (index(@temp[1], "DOID:2394") != -1)
                {
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

sub miRPD_miranda()
{
        open(FILE, "miranda_full.tsv") || die "Couldn't open file:  miranda_full.tsv";
        my @file = <FILE>;
        close FILE;

        shift(@file);

        my %miRNA;
        my @temp;
        foreach(@file)
        {   
                @temp = split("\t",$_);
                if (index(@temp[1], "DOID:2394") != -1) 
                {   
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

my @simple_files=("miRNA-all-hierarchical.txt#\t#0","miRNA-all-NMF.txt#\t#0","miRNA-initial.csv#,#0");
sub extract
{
	shift(@_);
	my @split = split("#",$_);
	my $filename = @split[0];
	my $sep = @split[1];
	my @miRNA_index = @split[2];

        open(FILE, $filename) || die "Couldn't open file: " . $filename . "\n";
        my @file = <FILE>;
        close FILE;

        shift(@file);

        my %miRNA;
        my @temp;
        foreach(@file)
        {
                @temp = split($sep, $_);
                $miRNA{lc(@temp[$miRNA_index])}++;
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

my @search_files=("mirdsnp-snp-mir-distance.csv#,#4#2#Ovarian","miranda_full.tsv#\t#1#0#DOID:2394","croft_full.tsv#\t#1#0#DOID:2394","Phenomir2.tbl#\t#2#5#Ovarian","miRCancer.txt#\t#1#0#ovarian","miRmasterlist#\t#1#0#ovarian","HMDD2#\t#2#1#Ovarian");
sub search
{
	shift(@_);
	@split = split("#",$_);
	my $filename = @split[0];
	my $sep = @split[1];
	my $search_index = @split[2];
	my $miRNA_index = @split[3];
	my $search = @split[4];

	#print $filename . "\t" . $sep . "\t" . $search_index . "\t" . $miRNA_index . "\t" . $search . "\n";
	
	open(FILE, $filename) || die "Couldn't open file: " . $filename;
       	my @file = <FILE>;
       	close FILE;

       	shift(@file);

       	my %miRNA;
       	my @temp;
       	foreach(@file)
       	{   
               	@temp = split($sep,$_);
               	if (index(@temp[$search_index], $search) != -1) 
               	{   
                    	$miRNA{lc(@temp[$miRNA_index])}++;
               	}
        }

        while ( my ($key) = each(%miRNA) )
       	{
               	$overlap{$key}++;
       	}
	#print $filename . "\n";

	while ( my ($key, $value) = each(%overlap) )
        {
        	#print $key . "=>" . $value . "\n";
	} 
}

foreach(@search_files)
{
	search($_);
}

foreach(@simple_files)
{
	extract($_);
}
#TCGA_hier;
#TCGA_NMF;
#marchini;
#HMDD2;
#miR2Disease;
#miRCancer;
#miRdSNP;
#Phenomir2;
#miRPD_croft;
#miRPD_miranda;
#search;

while ( my ($key, $value) = each(%overlap) )
{
	print $key . "=>" . $value . "\n";
}
