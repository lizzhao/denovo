#!/usr/bin/perl -w

use strict;
#use warnings;
#usage: Rank gene list by chromosome and coordinate first, adding ranking number in the gene list;
# then perl Pick-flanking-gene.pl gene.list query.list result.list 
open Gene, $ARGV[0]||die; #read snp file
open Loc,$ARGV[1] ||die; #read gene file
open OUT, ">$ARGV[2]" ||die; #read gene file
open OUT1, ">$ARGV[3]" ||die; #read gene file

my %gene;
my %chr;
my %left;
my %right;
my %rank;

#geneA 2L 1000 3000 1
#geneB 2L 5000 6000  2
#geneC 2L 8000 9000  3

#2L 3300 3800
#2L 7000 7500
#3R 9200 102000
#3R 7000 7600
while (<Gene>) {
	chomp;
	my @infor=split;
	$gene{"$infor[4]"} =$infor[0];
	$chr{"$infor[4]"} =$infor[1];
	$left{"$infor[4]"} =$infor[2];
	$right{"$infor[4]"} =$infor[3];
	$rank{"$infor[4]"} =$infor[4];
	
}
close Gene;

while (<Loc>) {
	chomp;
	my @infor=split;
	foreach my $key(keys %gene){
	if ($infor[0] eq $chr{$key}  and $infor[0] eq $chr{$key+1} and $infor[1] >= $right{$key} and $infor[2] <= $left{$key+1}) {
	print OUT "$gene{$key}\t$gene{$key+1}\n";
	print OUT1 "$gene{$key}\n$gene{$key+1}\n";

	}
	else {next;}
	}
	
