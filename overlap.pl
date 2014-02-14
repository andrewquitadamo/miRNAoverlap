#usr/bin/perl
#use strict;
#use warnings;

my %overlap;
my %overlap_names;

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
		$overlap_names{$key}=($overlap_names{$key} . " " . $filename);
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
		$overlap_names{$key}=($overlap_names{$key} . " " . $filename);
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

while ( my ($key, $value) = each(%overlap) )
{
	$output_num.= $key . "=>" . $value . "\n";
}

while ( my ($key, $value) = each(%overlap_names) )
{
	$output_names.= $key . "=>" . $value . "\n";
}

open FILE, ">"."miRNA_overlap_number" or die $!;
print FILE $output_num;
close FILE;

open FILE, ">"."miRNA_overlap_names" or die $!; 
print FILE $output_names;
close FILE;
