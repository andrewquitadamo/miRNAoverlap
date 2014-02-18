#usr/bin/perl
#use strict;
#use warnings;

my %overlap;
my %overlap_names;

my @simple_files=("miRNA-all-hierarchical.txt#\t#0#TCGA-hierarchical","miRNA-all-NMF.txt#\t#0#TCGA-NMF","miRNA-initial.csv#,#0#Marchini");
sub extract
{
	shift(@_);
	my @split = split("#",$_);
	my $filename = @split[0];
	my $sep = @split[1];
	my @miRNA_index = @split[2];
	my $name = @split[3];

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
		$overlap_names{$key}=($overlap_names{$key} . " " . $name);
        }
}

my @search_files=("mirdsnp-snp-mir-distance.csv#,#4#2#Ovarian#miRdSNP","miranda_full.tsv#\t#1#0#DOID:2394#miRPD-miranda","croft_full.tsv#\t#1#0#DOID:2394#miRPD-croft","Phenomir2.tbl#\t#2#5#Ovarian#Phenomir2","miRCancer.txt#\t#1#0#ovarian#miRCancer","miRmasterlist#\t#1#0#ovarian#miR2Disease","HMDD2#\t#2#1#Ovarian#HMDD2");
sub search
{
	shift(@_);
	@split = split("#",$_);
	my $filename = @split[0];
	my $sep = @split[1];
	my $search_index = @split[2];
	my $miRNA_index = @split[3];
	my $search = @split[4];
	my $name = @split[5];
	
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
		$overlap_names{$key}=($overlap_names{$key} . " " . $name);
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

my $output_num;
my $output_names;

foreach (sort {$overlap{$b} <=> $overlap{$a}} keys %overlap) 
{
	$output_num.= "$_\t$overlap{$_}\n";
	$output_names.="$_\t $overlap_names{$_}\n";
}

my %foundmiRNA;

$found_filename = "onlyCISresults.lm.quantile.normalized.FDRpoint1.txt";

open(FILE, $found_filename) || die "Couldn't open file: " . $found_filename . "\n";
my @file = <FILE>;
close FILE;

shift(@file);

foreach(@file)
{
        my @temp = split("\t", $_);
        $foundmiRNA{lc(@temp[0])}++;
}

@keys = keys %foundmiRNA;

my $output_overlap;
foreach(@keys)
{
	$output_overlap.= "$_\t$overlap_names{$_}\n";
}

open FILE, ">"."miRNA_overlap_number" or die $!;
print FILE $output_num;
close FILE;

open FILE, ">"."miRNA_overlap_names" or die $!; 
print FILE $output_names;
close FILE;

open FILE, ">"."miRNA_overlap" or die $!;
print FILE $output_names;
close FILE;
