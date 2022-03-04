#!/usr/bin/perl
#hsag.pl <gene_name>
#depends: hsa.csv
#maintainer: christophe.desterke@gmail.com
#license: GNU


use strict;
use warnings;

# import gene name argument
my ($search) = @ARGV;

# die if the argument number is different than 1
die "Usage ./hsa.pl <gene_name>\n" unless (@ARGV == 1);

# import database of gene annotation
open my $fh, '<', 'hsa.csv' or die "Cannot open: $!";


# declare my hash
my %hash;

# loop of reading my file handling to built hash dictionary 
while (my $line = <$fh>)
	{
	(my $gene,my $fonction) = split (',', $line,2);
  	$fonction =~ s/\s+/ /gs;
  	@hash{$gene}=$fonction;
	}

# output on screen
print "-" x 30 . "\n";


# conditional print of the description value if the search key is present in hash
if (exists $hash{$search})
	{print "The human gene \"$search\" is PRESENT in Ensembl-105 database (GRCh38.p13): \n\n";
	print "\t- $hash{$search}\n";
	}
	else {print "The human gene \"$search\" is ABSENT in Ensembl-105 database (GRCh38.p13)! \n";} 
	
# output on screen
print "-" x 30 . "\n";

# close my file handling
close ($fh);
