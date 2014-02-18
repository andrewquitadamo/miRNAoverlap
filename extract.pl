#usr/bin/perl
#use strict;
#use warnings;

my @search_files=("mirdsnp-snp-mir-distance.csv#,#4#2#Ovarian#miRdSNP","miranda_full.tsv#\t#1#0#DOID:2394#miRPD-miranda","croft_full.tsv#\t#1#0#DOID:2394#miRPD-croft","Phenomir2.tbl#\t#2#5#Ovarian#Phenomir2","miRCancer.txt#\t#1#0#ovarian#miRCancer","miRmasterlist#\t#1#0#ovarian#miR2Disease","HMDD2#\t#2#1#Ovarian#HMDD2");

my @simple_files=("miRNA-all-hierarchical.txt#\t#0#TCGA-hierarchical","miRNA-all-NMF.txt#\t#0#TCGA-NMF","miRNA-initial.csv#,#0#Marchini");

my $found_filename = "miRNA_overlap";

open(FILE, $found_filename) || die "Couldn't open file: " . $found_filename . "\n";
my @file = <FILE>;
close FILE;

my %miRNA;
my %output;
foreach(@file)
{
	my @temp = split("\t",$_);
	$miRNA{@temp[0]}=@temp[1];	
}

foreach(@simple_files)
{
	extract_simple($_);
}

sub extract_simple
{
	shift(@_);
        my @split = split("#",$_);
        my $filename = @split[0];
        my $sep = @split[1];
        my $miRNA_index = @split[2];
        my $name = @split[3];

        open(FILE, $filename) || die "Couldn't open file: " . $filename . "\n";
        my @file = <FILE>;
        close FILE;

        shift(@file);

	while ( my ($key, $value) = each(%miRNA))
	{
		if(index($value,$name) != -1)
		{
			foreach(@file)
			{
				my @temp = split($sep,$_);
				#print $_ . "\t" . $key . "\n";
				if(lc(@temp[$miRNA_index]) eq $key)
				{
					#TODO-Add filename to output
					$output{$key} = $output{$key} . $_ . "\n";	
					#print $_ . "\t" . $key . "\n";
				}
			}	
		}
	}	
}

print %output;
