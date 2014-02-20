#usr/bin/perl
#use strict;
#use warnings;

my $found_filename = "miRNA_overlap";

open(FILE, $found_filename) || die "Couldn't open file: " . $found_filename . "\n";
my @file = <FILE>;
close FILE;

my %miRNA;
my %overlap;
my $output;
foreach(@file)
{
        my @temp = split("\t",$_);
        $miRNA{@temp[0]}=@temp[1];
}

@keys = keys %miRNA;

my @search_files=("mirdsnp-snp-mir-distance.csv#,#4#2#Ovarian#miRdSNP","miranda_full.tsv#\t#1#0#DOID:2394#miRPD-miranda","croft_full.tsv#\t#1#0#DOID:2394#miRPD-croft","Phenomir2.tbl#\t#2#5#Ovarian#Phenomir2","miRCancer.txt#\t#1#0#ovarian#miRCancer","miRmasterlist#\t#1#0#ovarian#miR2Disease","HMDD2#\t#2#1#Ovarian#HMDD2");

foreach(@search_files)
{
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
	
	my $i =0;
	foreach(@file)
	{
		my @temp = split($sep,$_);
		my $j=0;
		my $up_expression;
		my $down_expression;
		my $expression;
		foreach(@keys)
		{
			my $key = $_;
			if((lc(@temp[$miRNA_index]) eq $_) && (index(@temp[$search_index], $search) == -1) && (@temp[$search_index] ne ""))
			{
				foreach(@temp)
				{
					if( (index($_,"overexpression") != -1) || (index($_,"upregulat") !=-1))
					{
						$up_expression = $_;
						$overlap{$key}=$overlap{$key}.=  $key . "\t" . "@temp[$search_index]" . "\t" . "0\n";
					}
					elsif( (index($_,"downregulat") != -1))
					{
						$down_expresson = $_;
						$overlap{$key}=$overlap{$key}.=  $key . "\t" . "@temp[$search_index]" . "\t" . "1\n";
					}
					elsif( (index($_,"expression") != -1))
					{
						$expression = $_;
						$overlap{$key}=$overlap{$key}.=  $key . "\t" . "@temp[$search_index]" .  "\t" . "2\n";
					}
					else
					{
						$overlap{$key}=$overlap{$key}.=  $key . "\t" . "@temp[$search_index]" . "\t3\n";
					}
				}
				#$overlap{$_}=$overlap{$_}.=  $_ . "\t" . @temp[$search_index] . "\t" . $expression . "\n"; 
				$up_expression = $down_expression = $expression = "";
			}
		}
		$i++;
	}
}

while ( my ($key, $value) = each(%overlap) ) {
	$output.= "$value\n";
}

open FILE, ">"."disease_overlap.txt" or die $!;
print FILE $output;
close FILE;
