#usr/bin/perl
#use strict;
#use warnings;

my $filename = "new_test.txt";

open(FILE, $filename) || die "Couldn't open file: " . $filename . "\n";
my @file = <FILE>;
close FILE;

my $doidfile = "HumanDO.obo";

open(FILE, $doidfile) || die "Couldn't open file: " . $doidfile . "\n";
my @doid = <FILE>;
close FILE;

%doidhash;

my $i;
foreach(@doid)
{
	if ((index($_,"id: DOID:")!=-1))
	{
		#print $_;
		my @tempdoid = split("id: ",$_);
		#print @tempdoid[1];
		my @tempname = split("name: ",@doid[$i+1]);
		#print @tempname[1];
		@tempdoid[1] =~ s/^\s+|\s+$//g;
		$doidhash{@tempdoid[1]}=(@tempname[1]);
	}
	$i++;
}

while ( my ($key, $value) = each(%doidhash) ) 
{ 
        #print "$key $value\n";
}



my @doidlines;
my @otherlines;
foreach(@file)
{
	if ((index($_,"DOID:")!=-1))
	{
		push(@doidlines,$_);	
	}
	else
	{
		push(@otherlines,$_);
	}
}

my $output;
foreach(@doidlines)
{
	my @temp = split("\t",$_);
	#print $doidhash{@temp[1]};
	@temp[1] = $doidhash{@temp[1]};
	@temp[1] =~ s/^\s+|\s+$//g;
	$output.=join("\t",@temp);
}

foreach(@otherlines)
{
	if ($_ ne "")
	{
		$output.=$_;
	}
}

open FILE, ">"."final.txt" or die $!; 
print FILE $output;
close FILE;
