#!/usr/bin/perl -w

use strict;
use Getopt::Long;
open List1,"$ARGV[0]" || die"$!";#list1<lsit2
open List2,"$ARGV[1]" || die"$!";
#list1
#2L	21928856	21931769	21928418	-438
#2L	21928856	21931769	21928784	-72
#2R	16653944	16655453	16653572	-372

#list2
#2L	5066	C	G	AC=1	0	1	1	0	1	1
#2L	5073	TTAGATTGCCTCTC	T	AC=135	0	1	1	0	1	1
#2L	5083	TCTC	T	AC=11	0	0	0	0	0	0
open OUT,">$ARGV[2]" || die"$!";
my %hash;
while (<List1>) {
		
        chomp;
		my @infor=split;
        $hash{"$infor[0]\t$infor[3]"}=$_;
}

while (<List2>) {
        chomp;
		my @infor=split;
        if (exists $hash{"$infor[0]\t$infor[1]"}) {
                print OUT $_."\n";
        }
}
