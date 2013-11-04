#!/usr/bin/perl -w

use strict;
open G1,"$ARGV[0]" || die"$!";
open G2,"$ARGV[1]" || die"$!";
open OUT,">$ARGV[2]" || die"$!";
#coordinate ancestral and derived allele
#3R      11115        A T     T
#3R      11361        A G     G
#3R      11364        T G     G
#3R      11364        T C     C
#3R      27898819        T G     G
#3R      27898798        G A     A

# SNP information in DGRP freeeze2
#2L	11113	A	G	UT;AC=1	0	0	0	0	0	0
#2L	11115	GT	G	UT;HP;AC=1	0	0	1	0	0	0
#2L	11206	C	T	UT;AC=15	0	0	0	0	0	0
#2L	11255	A	T	CD;NS;AC=12	0	0	0	0	0	0
#2L	11361	A	G	IN;AC=3	0	0	0	0	0	0
# if ancestal allele is not the reference one, then change 1 to 0 and 0 to 1, at the end make all the ancestal are 0 and derived are 1

my %hash;
while (<G1>) {
        chomp;
        my @infor=split;
        $hash{"$infor[0]\t$infor[1]"}=$_;
}
close G1;

while (<G2>) {
        chomp;
        my @infor=split;
        if(exists $hash{"$infor[0]\t$infor[1]"}){
				my $R304 = $infor[5];
				$R304 =~ s/1/2/g;
				$R304 =~ s/0/1/g;
				$R304 =~ s/2/0/g;
				
				my $R307 = $infor[6];
				$R307 =~ s/1/2/g;
				$R307 =~ s/0/1/g;
				$R307 =~ s/2/0/g;
				
				my $R357 = $infor[7];
				$R357 =~ s/1/2/g;
				$R357 =~ s/0/1/g;
				$R357 =~ s/2/0/g;
				
				my $R360 = $infor[8];
				$R360 =~ s/1/2/g;
				$R360 =~ s/0/1/g;
				$R360 =~ s/2/0/g;
				
				my $R399 = $infor[9];
				$R399 =~ s/1/2/g;
				$R399 =~ s/0/1/g;
				$R399 =~ s/2/0/g;
				
				my $R517 = $infor[10];
				$R517 =~ s/1/2/g;
				$R517 =~ s/0/1/g;
				$R517 =~ s/2/0/g;


				print OUT "$infor[0]\t$infor[1]\t$infor[3]\t$infor[2]\t$infor[4]\t$R304\t$R307\t$R357\t$R360\t$R399\t$R517\n";
        }
       else{ 
       print OUT "$_\n";
       }
}
