#usr/bin/perl
#use strict;
#use warnings;

my $filename = "uniq_final.txt";

open(FILE, $filename) || die "Couldn't open file: " . $filename . "\n";
my @file = <FILE>;
close FILE;

%over;
%under;
%none;

$output;

foreach(@file)
{
	my @temp = split("\t",$_);
	if (@temp[2]==0)
	{
		$over{@temp[0]}=$over{@temp[0]}.="," . @temp[1];
	}
	elsif (@temp[2]==1)
	{
		$over{@temp[0]}=$under{@temp[0]}.="," . @temp[1];
	}
	else
	{
		$over{@temp[0]}=$none{@temp[0]}.="," . @temp[1];
	}
}

my @keys_over = keys %over;
my @keys_under = keys %under;
my @keys_none = keys %none;

foreach(@keys_over)
{
	$output.=$_ . "\tover\t" . $over{$_} . "\n";
	$output.=$_ . "\tunder\t" . $under{$_} . "\n";
	$output.=$_ . "\tnone\t" . $none{$_} . "\n";
}

foreach(@keys_under)
{
	#$output.=$_ . "\tunder\t" . $under{$_} . "\n";
}

foreach(@keys_none)
{
	#$output.=$_ . "\tnone\t" . $none{$_} . "\n";
}
open FILE, ">"."table.txt" or die $!; 
print FILE $output;
close FILE;
