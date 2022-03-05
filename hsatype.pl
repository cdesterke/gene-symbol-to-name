#!/usr/bin/perl
#hsatype.pl <gene_name>
#depends: genetype.txt
#maintainer: christophe.desterke@gmail.com
#license: GNU


use strict;
use warnings;

# import gene name argument
my ($search) = @ARGV;

# die if the argument number is different than 1
die "Usage ./hsatype.pl <gene_name>\n" unless (@ARGV == 1);

# import database of gene annotation
open my $fh, '<', 'genetype.txt' or die "Cannot open: $!";


# declare my hash
my %hashname;
my %hashtype;
# loop of reading my file handling to built hash dictionary 
while (my $line = <$fh>)
	{
	(my $gene,my $type,my $name) = split (',', $line,3);
  	$type =~ s/\s+/ /gs;
  	$name =~ s/\s+/ /gs;
  	@hashname{$gene}=$name;
  	@hashtype{$gene}=$type;
	}
	

# output on screen
print "-" x 30 . "\n";


# conditional print of the description value if the search key is present in hash
if (exists $hashname{$search})
	{print "The human gene \"$search\" is PRESENT in Ensembl-105 database (GRCh38.p13): \n\n";
	print "\t- $hashname{$search}\n\n";}
if (exists $hashtype{$search})
	{print "Corresponding TYPE of gene: \n\n";
	print "\t- $hashtype{$search}\n";}
	
else {print "The human gene \"$search\" is ABSENT in Ensembl-105 database (GRCh38.p13)! \n";} 
	
# output on screen
print "-" x 30 . "\n";

# close my file handling
close ($fh);
