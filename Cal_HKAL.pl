#!/usr/bin/perl -w
# calculate the hkal based on the hkal file; need to add different lines together to process
# use : awk '{a[$1"\t"$2"\t"$3]+=$4}END{for(j in a )print j,a[j]}' this.result.file > new.file
use strict;
use Getopt::Long;
open List1,"$ARGV[0]" || die"$!";#list1<lsit2
open List2,"$ARGV[1]" || die"$!";
open OUT,">$ARGV[2]" || die"$!";
#chr2L   11762   13250   -7.9057
#chr2L   13251   14732   -7.93692
#chr2L   14733   16993   -5.75122

#2L 1000 1800
#2L 14600 15200

my %start;
my %end;
my %hkal;
my %chr;
while (<List1>) {		
        chomp;
	   my @infor=split;
	    $chr{"$infor[0]\t$infor[1]"} = $infor[0];
        $start{"$infor[0]\t$infor[1]"} = $infor[1];
        $end{"$infor[0]\t$infor[1]"} = $infor[2];
        $hkal{"$infor[0]\t$infor[1]"} = $infor[3];
}
my %hka;
my $hka;
my %length;
my $length;
my $res;
my %res;

while (<List2>) {
        chomp;
		my @infor=split;
		$hka=0;
        foreach my $key (keys %start) {
        	if ($infor[0] eq $chr{$key} and $infor[1] >= $start{$key} and $infor[2] <= $end{$key}){
       		my $hka = $hkal{$key};
       		$length = $infor[2] -$infor[1];
      		print OUT "$infor[0]\t$infor[1]\t$infor[2]\t$hka\t$length\n";
     #  		print "hello world\n";
        	} 
        	if ($infor[0] eq $chr{$key} and $infor[1] >= $start{$key} and $infor[1] < $end{$key} and $infor[2] >= $end{$key}){
	        	$length = $end{$key} -$infor[1];
        	my $hka = $hkal{$key}*$length/800;
        	print OUT "$infor[0]\t$infor[1]\t$infor[2]\t$hka\t$length\n";
        	}
        	if ($infor[0] eq $chr{$key} and $infor[1] <= $start{$key} and $infor[2] > $start{$key} and $infor[2] <= $end{$key}){
        	$length = $infor[2]-$start{$key};
        	my $hka = $hkal{$key}*$length/800;
        	print OUT "$infor[0]\t$infor[1]\t$infor[2]\t$hka\t$length\n";
        	}
        	if ($infor[0] eq $chr{$key} and $infor[1] <= $start{$key} and $infor[2] >= $end{$key}){
        	$length = $end{$key}-$start{$key};
        	my $hka = $hkal{$key}*$length/800;
        	print OUT "$infor[0]\t$infor[1]\t$infor[2]\t$hka\t$length\n";
        	}
			else 
			{next;}
		}
}
exit;

