#!/usr/bin/perl
#hsatype.pl <gene_name>
#depends: hugo.csv
#maintainer: christophe.desterke@gmail.com
#license: GNU


use strict;
use warnings;

# import gene name argument
my ($search) = @ARGV;

# die if the argument number is different than 1
die "Usage ./hugo.pl <gene_name>\n" unless (@ARGV == 1);

# import database of gene annotation
open my $fh, '<', 'hugo.csv' or die "Cannot open: $!";


# declare my hash
my %hashname;
my %hashalias;
my %hashchromosome;
my %hashtype;
my %hashgroup;
# loop of reading my file handling to built hash dictionary 
while (my $line = <$fh>)
	{
	(my $gene,my $name,my $alias,my $chromosome, my $type, my $group) = split (';', $line,6);
  	$type =~ s/\s+/ /gs;
  	$name =~ s/\s+/ /gs;
  	$gene =~ s/\s+/ /gs;
  	$alias =~ s/\s+/ /gs;
  	$chromosome =~ s/\s+/ /gs;
  	$group =~ s/\s+/ /gs;
  	@hashname{$gene}=$name;
  	@hashalias{$gene}=$alias;
  	@hashchromosome{$gene}=$chromosome;
  	@hashtype{$gene}=$type;
  	@hashgroup{$gene}=$group;
	}

# output on screen
print "-" x 30 . "\n";


# conditional print of the description value if the search key is present in hash
if (exists $hashname{$search})
	{print "The human gene \"$search\" is PRESENT in Homo sapiens database : \n\n";
	print "\t- $hashname{$search}\n\n";}

if (exists $hashalias{$search})
	{print "Corresponding gene alias: \n\n";
	print "\t- $hashalias{$search}\n\n";}

if (exists $hashchromosome{$search})
	{print "Human chromosome locus: \n\n";
	print "\t- $hashchromosome{$search}\n\n";}
	
if (exists $hashgroup{$search})
	{print "Gene group: \n\n";
	print "\t- $hashgroup{$search}\n\n";}

if (exists $hashtype{$search})
	{print "Corresponding TYPE of gene: \n\n";
	print "\t- $hashtype{$search}\n\n";}
	
else {print "The human gene \"$search\" is ABSENT in Homo sapiens database ! \n";} 
	
# output on screen
print "-" x 30 . "\n";

# close my file handling
close ($fh);
